import 'dart:async';
import 'dart:convert';
import 'package:darq/darq.dart';
import 'package:universal_io/io.dart';
import 'dart:typed_data';
import 'package:injector/injector.dart';
import 'package:posapp/logic/interfaces/IHTTP.dart';
import 'package:posapp/logic/models/IModelFactory.dart';

class NetworkException implements Exception {
  final int statusCode;
  final dynamic body;

  NetworkException({required this.statusCode, required this.body});
}

class IOHTTP implements IHTTP {
  final String _baseUrl = "https://localhost:5001/";
  final Map<String, String> _headers = new Map<String, String>();

  void log(String method, String endpoint, [Map<String, dynamic>? queryArgs]) {
    final url = _urlStringConstructor(endpoint, queryArgs);
    print("HTTP $method: $url");
  }

  HttpClient _makeClient() {
    final client = HttpClient();
    client.badCertificateCallback = (a, b, c) => true;
    return client;
  }

  String _urlStringConstructor(String endpoint,
      [Map<String, dynamic>? queryArgs]) {
    var url = _baseUrl + endpoint;
    if (queryArgs != null) {
      url +=
          "?${queryArgs.entries.map((e) => "${e.key}=${e.value}").join('&')}";
    }
    return url;
  }

  Uri _urlConstructor(String endpoint, [Map<String, dynamic>? queryArgs]) {
    return Uri.parse(_urlStringConstructor(endpoint, queryArgs));
  }

  HttpClientRequest _injectHeaders(HttpClientRequest req) {
    req.headers.add("content-type", "application/json");
    for (var entry in _headers.entries) {
      req.headers.add(entry.key, entry.value);
    }
    return req;
  }

  HttpClientRequest _writeToBody(
      HttpClientRequest req, dynamic body, void Function(double)? progress) {
    if (body == null) return req;
    List<int> payload;
    if (body is IJsonSerializable) {
      payload = utf8.encode(jsonEncode(body.toJson()));
    } else if (body is List<IJsonSerializable>) {
      payload = utf8.encode(jsonEncode(body.map((e) => e.toJson())));
    } else {
      payload = utf8.encode(jsonEncode(body));
    }
    req.add(payload);
    return req;
  }

  Future<String> _readResponseAsString(
      HttpClientResponse response, void Function(double)? progress) {
    final completer = Completer<String>();
    final buffer = <int>[];
    response.listen((data) {
      buffer.addAll(data);
      if (response.contentLength != -1 && progress != null) {
        progress(buffer.length / response.contentLength);
      }
    }, onDone: () => completer.complete(utf8.decode(buffer)));
    return completer.future;
  }

  Future<Uint8List> _readResponseAsBytes(
      HttpClientResponse response, void Function(double)? progress) {
    final completer = Completer<Uint8List>();
    final buffer = <int>[];
    response.listen((data) {
      buffer.addAll(data);
      if (response.contentLength != -1 && progress != null) {
        progress(buffer.length / response.contentLength);
      }
    }, onDone: () => completer.complete(Uint8List.fromList(buffer)));
    return completer.future;
  }

  Future<Tuple2<List<T>?, dynamic>> _parseBodyOf<T extends IJsonSerializable>(
      HttpClientResponse response, void Function(double)? progress) async {
    dynamic resBody;
    try {
      final responseFactory = Injector.appInstance.get<IModelFactory<T>>();
      resBody = jsonDecode(await _readResponseAsString(response, progress));
      List<T> result;
      if (resBody is List) {
        result = resBody.map((e) => responseFactory.fromJson(e)).toList();
      } else {
        result = [responseFactory.fromJson(resBody)];
      }
      return Tuple2(result, resBody);
    } catch (ex) {
      return Tuple2(null, resBody);
    }
  }

  Future<HttpClientResponse> _processRequest(HttpClientRequest req,
      dynamic body, void Function(double)? progress) async {
    req = _injectHeaders(req);
    req = _writeToBody(req, body, progress);
    return await req.close();
  }

  Future<HttpClientResponse> _sendRequestHelper(
      HTTPRequestMethod method,
      String endpoint,
      Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress) async {
    HttpClientRequest? req;
    switch (method) {
      case HTTPRequestMethod.GET:
        req = await _makeClient().getUrl(_urlConstructor(endpoint, queryArgs));
        break;
      case HTTPRequestMethod.POST:
        req = await _makeClient().postUrl(_urlConstructor(endpoint, queryArgs));
        break;
      case HTTPRequestMethod.PUT:
        req = await _makeClient().putUrl(_urlConstructor(endpoint, queryArgs));
        break;
      case HTTPRequestMethod.DELETE:
        req =
            await _makeClient().deleteUrl(_urlConstructor(endpoint, queryArgs));
        break;
    }
    return await _processRequest(req, body, progress);
  }

  Future<BackendResultWithBody<O>>
      sendRequestWithResult<O extends IJsonSerializable>(
          HTTPRequestMethod method, String endpoint,
          {Map<String, dynamic>? queryArgs,
          dynamic body,
          void Function(double)? progress}) async {
    while (true) {
      try {
        final response = await _sendRequestHelper(
            method, endpoint, queryArgs, body, progress);
        final res = await _parseBodyOf<O>(response, progress);
        return BackendResultWithBody(
            statusCode: response.statusCode,
            body: res.item0,
            rawBody: res.item1);
      } on SocketException {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  @override
  Future<BackendResult> sendRequest(HTTPRequestMethod method, String endpoint,
      {Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress}) async {
    while (true) {
      try {
        final response = await _sendRequestHelper(
            method, endpoint, queryArgs, body, progress);
        return BackendResult(statusCode: response.statusCode);
      } on SocketException {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  @override
  Future<Uint8List> getImage(String endpoint,
      {Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress}) async {
    while (true) {
      try {
        final req =
            await _makeClient().getUrl(_urlConstructor(endpoint, queryArgs));
        final response = await _processRequest(req, body, progress);
        return await _readResponseAsBytes(response, progress);
      } on SocketException {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  @override
  Future<BackendResult> delete(String endpoint,
      {Map<String, dynamic>? queryArgs, body}) {
    return sendRequest(HTTPRequestMethod.DELETE, endpoint,
        queryArgs: queryArgs, body: body);
  }

  @override
  Future<BackendResult> get(String endpoint,
      {Map<String, dynamic>? queryArgs, body}) {
    return sendRequest(HTTPRequestMethod.GET, endpoint,
        queryArgs: queryArgs, body: body);
  }

  @override
  Future<BackendResult> post(String endpoint,
      {Map<String, dynamic>? queryArgs, body}) {
    return sendRequest(HTTPRequestMethod.POST, endpoint,
        queryArgs: queryArgs, body: body);
  }

  @override
  Future<BackendResult> put(String endpoint,
      {Map<String, dynamic>? queryArgs, body}) {
    return sendRequest(HTTPRequestMethod.PUT, endpoint,
        queryArgs: queryArgs, body: body);
  }

  @override
  Future<BackendResultWithBody<O>> rdelete<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      body,
      void Function(double)? progress}) {
    return sendRequestWithResult<O>(HTTPRequestMethod.DELETE, endpoint,
        queryArgs: queryArgs, body: body);
  }

  @override
  Future<BackendResultWithBody<O>> rget<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      body,
      void Function(double)? progress}) {
    return sendRequestWithResult<O>(HTTPRequestMethod.GET, endpoint,
        queryArgs: queryArgs, body: body);
  }

  @override
  Future<BackendResultWithBody<O>> rpost<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      body,
      void Function(double)? progress}) {
    return sendRequestWithResult<O>(HTTPRequestMethod.POST, endpoint,
        queryArgs: queryArgs, body: body);
  }

  @override
  Future<BackendResultWithBody<O>> rput<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      body,
      void Function(double)? progress}) {
    return sendRequestWithResult<O>(HTTPRequestMethod.PUT, endpoint,
        queryArgs: queryArgs, body: body);
  }

  @override
  void setHeader(String key, String value) {
    _headers[key] = value;
  }

  @override
  void setJWToken(String token) {
    _headers["authorization"] = "Bearer $token";
  }
}
