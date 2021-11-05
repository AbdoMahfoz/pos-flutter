import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:injector/injector.dart';
import 'package:posapp/logic/interfaces/IHTTP.dart';
import 'package:posapp/logic/models/IModelFactory.dart';

class HTTP implements IHTTP {
  final String _baseUrl = "https://localhost:5001/";
  final _headers = <String, String>{"content-type": "application/json"};

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

  http.Request _writeToBody(http.Request req, dynamic body) {
    if (body == null) return req;
    if (body is IJsonSerializable) {
      req.body = jsonEncode(body.toJson());
    } else if (body is List<IJsonSerializable>) {
      req.body = jsonEncode(body.map((e) => e.toJson()));
    } else {
      req.body = jsonEncode(body);
    }
    return req;
  }

  Future<O> _retryWhenFail<O>(Future<O> Function() func) async {
    while (true) {
      try {
        return await func();
      } on http.ClientException {
        await Future.delayed(const Duration(seconds: 2));
      }
    }
  }

  Future<http.StreamedResponse> _sendRequestHelper(HTTPRequestMethod method,
      String endpoint, Map<String, dynamic>? queryArgs, body) async {
    var request =
        http.Request(method.toString(), _urlConstructor(endpoint, queryArgs));
    request.headers.addAll(_headers);
    request = _writeToBody(request, body);
    return request.send();
  }

  Future<List<int>> _readBytes(
      http.StreamedResponse response, void Function(double)? progress) async {
    final bytes = <int>[];
    await response.stream.listen((value) {
      bytes.addAll(value);
      if (response.contentLength != null && progress != null) {
        progress(bytes.length / response.contentLength!);
      }
    }).asFuture();
    return bytes;
  }

  dynamic _readRaw(List<int> bytes) {
    return jsonDecode(utf8.decode(bytes));
  }

  Future<List<O>?> _readAsObject<O extends IJsonSerializable>(
      List<int> bytes) async {
    try {
      final bodyString = utf8.decode(bytes);
      final responseFactory = Injector.appInstance.get<IModelFactory<O>>();
      final resBody = jsonDecode(bodyString);
      List<O> result;
      if (resBody is List) {
        result = resBody.map((e) => responseFactory.fromJson(e)).toList();
      } else {
        result = [responseFactory.fromJson(resBody)];
      }
      return result;
    } catch (ex) {
      return null;
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
        queryArgs: queryArgs, body: body, progress: progress);
  }

  @override
  Future<BackendResultWithBody<O>> rget<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      body,
      void Function(double)? progress}) {
    return sendRequestWithResult<O>(HTTPRequestMethod.GET, endpoint,
        queryArgs: queryArgs, body: body, progress: progress);
  }

  @override
  Future<BackendResultWithBody<O>> rpost<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      body,
      void Function(double)? progress}) {
    return sendRequestWithResult<O>(HTTPRequestMethod.POST, endpoint,
        queryArgs: queryArgs, body: body, progress: progress);
  }

  @override
  Future<BackendResultWithBody<O>> rput<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      body,
      void Function(double)? progress}) {
    return sendRequestWithResult<O>(HTTPRequestMethod.PUT, endpoint,
        queryArgs: queryArgs, body: body, progress: progress);
  }

  @override
  Future<BackendResult> sendRequest(HTTPRequestMethod method, String endpoint,
          {Map<String, dynamic>? queryArgs,
          body,
          void Function(double)? progress}) async =>
      _retryWhenFail(() async {
        var response =
            await _sendRequestHelper(method, endpoint, queryArgs, body);
        return BackendResult(statusCode: response.statusCode);
      });

  @override
  Future<BackendResultWithBody<O>>
      sendRequestWithResult<O extends IJsonSerializable>(
              HTTPRequestMethod method, String endpoint,
              {Map<String, dynamic>? queryArgs,
              dynamic body,
              void Function(double)? progress}) async =>
          _retryWhenFail(() async {
            final response =
                await _sendRequestHelper(method, endpoint, queryArgs, body);
            final bytes = await _readBytes(response, progress);
            final result = await _readAsObject<O>(bytes);
            return BackendResultWithBody<O>(
                statusCode: response.statusCode,
                body: result,
                rawBody: _readRaw(bytes));
          });

  @override
  void setHeader(String key, String value) {
    _headers[key] = value;
  }

  @override
  void setJWToken(String token) {
    setHeader("Authorization", "Bearer $token");
  }

  @override
  Future<Uint8List> getImage(String endpoint,
      {Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress}) async {
    final response = await _sendRequestHelper(
        HTTPRequestMethod.GET, endpoint, queryArgs, body);
    final bytes = await _readBytes(response, progress);
    return Uint8List.fromList(bytes);
  }
}
