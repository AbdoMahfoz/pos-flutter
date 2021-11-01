import 'package:posapp/logic/models/IModelFactory.dart';

class LoginResult implements IJsonSerializable {
  final String userId;
  final String token;
  final int expiresIn;

  LoginResult(this.userId, this.token, this.expiresIn);

  @override
  Map<String, dynamic> toJson() {
    return {"userId": userId, "token": token, "expiresIn": expiresIn};
  }
}

class LoginResultFactory implements IModelFactory<LoginResult> {
  @override
  LoginResult fromJson(Map<String, dynamic> jsonMap) {
    return LoginResult(
        jsonMap["userId"], jsonMap["token"], jsonMap["expiresIn"]);
  }
}
