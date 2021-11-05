import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:injector/injector.dart';
import 'package:posapp/logic/interfaces/IHTTP.dart';
import 'package:posapp/logic/models/IModelFactory.dart';

class NetworkException implements Exception {
  final int statusCode;
  final dynamic body;

  NetworkException({required this.statusCode, required this.body});
}

class HTTP implements IHTTP {
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

  HttpClientRequest _writeToBody(HttpClientRequest req, dynamic body) {
    if (body == null) return req;
    if (body is IJsonSerializable) {
      req.add(utf8.encode(jsonEncode(body.toJson())));
    } else if (body is List<IJsonSerializable>) {
      req.add(utf8.encode(jsonEncode(body.map((e) => e.toJson()))));
    } else {
      req.add(utf8.encode(jsonEncode(body)));
    }
    return req;
  }

  Future<int> _statusCodeOf(HttpClientResponse response) async {
    if (response.statusCode >= 300) {
      throw new NetworkException(
          statusCode: response.statusCode,
          body: jsonDecode(await _readResponseAsString(response)));
    }
    return response.statusCode;
  }

  Future<String> _readResponseAsString(HttpClientResponse response) {
    final completer = Completer<String>();
    final contents = StringBuffer();
    response.transform(utf8.decoder).listen((data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }

  Future<Uint8List> _readResponseAsBytes(HttpClientResponse response) {
    final completer = Completer<Uint8List>();
    final contents = <int>[];
    response.listen((data) {
      contents.addAll(data);
    }, onDone: () => completer.complete(Uint8List.fromList(contents)));
    return completer.future;
  }

  Future<List<T>> _parseBodyOf<T extends IJsonSerializable>(
      HttpClientResponse response) async {
    final responseFactory = Injector.appInstance.get<IModelFactory<T>>();
    final resBody = jsonDecode(await _readResponseAsString(response));
    List<T> result;
    if (resBody is List) {
      result = resBody.map((e) => responseFactory.fromJson(e)).toList();
    } else {
      result = [responseFactory.fromJson(resBody)];
    }
    return result;
  }

  Future<HttpClientResponse> _processRequest(
      HttpClientRequest req, dynamic body) async {
    req = _injectHeaders(req);
    req = _writeToBody(req, body);
    return await req.close();
  }

  Future<HttpClientResponse> _sendRequestHelper(
      HTTPRequestMethod method, String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body}) async {
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
    return await _processRequest(req, body);
  }

  Future<BackendResultWithBody<O>> sendRequestWithResult<O>(
      HTTPRequestMethod method, String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body}) async {
    while (true) {
      try {
        final response = await _sendRequestHelper(method, endpoint,
            queryArgs: queryArgs, body: body);
        return BackendResultWithBody(
            statusCode: await _statusCodeOf(response),
            body: await _parseBodyOf(response));
      } on SocketException {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  @override
  Future<BackendResult> sendRequest(HTTPRequestMethod method, String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body}) async {
    while (true) {
      try {
        final response = await _sendRequestHelper(method, endpoint,
            queryArgs: queryArgs, body: body);
        return BackendResult(statusCode: await _statusCodeOf(response));
      } on SocketException {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  @override
  Future<Uint8List> getImage(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body}) async {
    while (true) {
      try {
        final req =
            await _makeClient().getUrl(_urlConstructor(endpoint, queryArgs));
        final response = await _processRequest(req, body);
        return await _readResponseAsBytes(response);
      } on SocketException {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
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
