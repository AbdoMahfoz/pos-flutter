import 'dart:typed_data';

import 'package:posapp/logic/models/IModelFactory.dart';

class BackendResultWithBody<T> extends BackendResult {
  final List<T>? body;
  final dynamic rawBody;

  BackendResultWithBody(
      {required int statusCode, required this.body, required this.rawBody})
      : super(statusCode: statusCode);
}

class BackendResult {
  final int statusCode;

  BackendResult({required this.statusCode});
}

enum HTTPRequestMethod { GET, POST, PUT, DELETE }

abstract class IHTTP {
  Future<BackendResultWithBody<O>>
      sendRequestWithResult<O extends IJsonSerializable>(
          HTTPRequestMethod method, String endpoint,
          {Map<String, dynamic>? queryArgs,
          dynamic body,
          void Function(double)? progress});

  Future<BackendResultWithBody<O>> rget<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress});

  Future<BackendResultWithBody<O>> rpost<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress});

  Future<BackendResultWithBody<O>> rput<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress});

  Future<BackendResultWithBody<O>> rdelete<O extends IJsonSerializable>(
      String endpoint,
      {Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress});

  Future<BackendResult> sendRequest(HTTPRequestMethod method, String endpoint,
      {Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress});

  Future<BackendResult> get(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResult> post(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResult> put(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResult> delete(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<Uint8List> getImage(String endpoint,
      {Map<String, dynamic>? queryArgs,
      dynamic body,
      void Function(double)? progress});

  void setHeader(String key, String value);

  void setJWToken(String token);
}
