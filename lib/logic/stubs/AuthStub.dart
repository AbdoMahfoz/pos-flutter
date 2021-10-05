import 'package:posapp/logic/interfaces/IAuth.dart';

class AuthStub implements IAuth {
  @override
  Future<bool> login(String username, String password) async {
    await Future.delayed(Duration(seconds: 2));
    if (username == "admin" && password == "admin") {
      return true;
    }
    return false;
  }
}
