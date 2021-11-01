import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:injector/injector.dart';
import 'package:mutex/mutex.dart';
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
  final headerMutex = Mutex();

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
    headerMutex.acquire();
    req.headers.add("content-type", "application/json");
    for (var entry in _headers.entries) {
      req.headers.add(entry.key, entry.value);
    }
    headerMutex.release();
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

  @override
  Future<BackendResultWithBody<O>> get<O>(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body}) async {
    log("GET", endpoint, queryArgs);
    final req =
        await _makeClient().getUrl(_urlConstructor(endpoint, queryArgs));
    final response = await _processRequest(req, body);
    return BackendResultWithBody(
        statusCode: await _statusCodeOf(response),
        body: await _parseBodyOf(response));
  }

  @override
  Future<BackendResult> post(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body}) async {
    log("POST", endpoint, queryArgs);
    final req =
        await _makeClient().postUrl(_urlConstructor(endpoint, queryArgs));
    final response = await _processRequest(req, body);
    return BackendResult(statusCode: await _statusCodeOf(response));
  }

  @override
  Future<BackendResultWithBody<O>> postWithResultBody<O>(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body}) async {
    log("POST", endpoint, queryArgs);
    final req =
        await _makeClient().postUrl(_urlConstructor(endpoint, queryArgs));
    final response = await _processRequest(req, body);
    return BackendResultWithBody(
        statusCode: await _statusCodeOf(response),
        body: await _parseBodyOf(response));
  }

  @override
  Future<Uint8List> getImage(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body}) async {
    final req =
        await _makeClient().getUrl(_urlConstructor(endpoint, queryArgs));
    final response = await _processRequest(req, body);
    return await _readResponseAsBytes(response);
  }

  @override
  void setHeader(String key, String value) {
    headerMutex.acquire();
    _headers[key] = value;
    headerMutex.release();
  }

  @override
  void setJWToken(String token) {
    headerMutex.acquire();
    _headers["authorization"] = "Bearer $token";
    headerMutex.release();
  }
}
