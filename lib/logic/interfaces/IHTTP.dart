import 'dart:typed_data';

class BackendResultWithBody<T> extends BackendResult {
  final List<T> body;

  BackendResultWithBody({required int statusCode, required this.body})
      : super(statusCode: statusCode);
}

class BackendResult {
  final int statusCode;

  BackendResult({required this.statusCode});
}

abstract class IHTTP {
  Future<BackendResultWithBody<O>> get<O>(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResult> post(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResultWithBody<O>> postWithResultBody<O>(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<Uint8List> getImage(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  void setHeader(String key, String value);

  void setJWToken(String token);
}
