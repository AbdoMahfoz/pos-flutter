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

enum HTTPRequestMethod { GET, POST, PUT, DELETE }

abstract class IHTTP {
  Future<BackendResultWithBody<O>> sendRequestWithResult<O>(
      HTTPRequestMethod method, String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResultWithBody<O>> rget<O>(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResultWithBody<O>> rpost<O>(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResultWithBody<O>> rput<O>(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResultWithBody<O>> rdelete<O>(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResult> sendRequest(HTTPRequestMethod method, String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResult> get(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResult> post(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResult> put(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<BackendResult> delete(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  Future<Uint8List> getImage(String endpoint,
      {Map<String, dynamic>? queryArgs, dynamic body});

  void setHeader(String key, String value);

  void setJWToken(String token);
}
