import 'dart:async';

import 'package:injector/injector.dart';
import 'package:posapp/logic/implementations/HTTP.dart';
import 'package:posapp/logic/interfaces/IAuth.dart';
import 'package:posapp/logic/interfaces/IHTTP.dart';
import 'package:posapp/logic/models/AuthModels.dart';
import 'package:rxdart/rxdart.dart';

class Auth extends IAuth {
  final _loggedInController = BehaviorSubject<bool>.seeded(false);

  @override
  Stream<bool> get loggedInStream => _loggedInController.stream;
  Future? tokenRenewal;
  IHTTP http = Injector.appInstance.get<IHTTP>();

  bool _processToken(BackendResultWithBody<LoginResult> res) {
    try {
      http.setJWToken(res.body[0].token);
      tokenRenewal = Future.delayed(
          Duration(minutes: res.body[0].expiresIn - 1),
          () => _tokenRefresh(res.body[0].token));
      if (_loggedInController.value == false) {
        _loggedInController.add(true);
      }
      return true;
    } catch (e) {
      if (e is NetworkException) {
        if (e.statusCode == 404) {
          if (_loggedInController.value == true) {
            _loggedInController.add(false);
          }
          return false;
        }
      }
      throw e;
    }
  }

  void _tokenRefresh(String oldToken) async {
    var res = await http.sendRequestWithResult<LoginResult>(
        HTTPRequestMethod.POST, 'api/Account/RefreshToken');
    _processToken(res);
  }

  @override
  Future<bool> login(String username, String password,
      {bool requireAdmin = false}) async {
    try {
      var res = await http.sendRequestWithResult<LoginResult>(
          HTTPRequestMethod.POST, 'api/Account/Token', body: {
        "username": username,
        "password": password,
        "admin": requireAdmin
      });
      return _processToken(res);
    } catch (ex) {
      if (ex is NetworkException) {
        if (ex.statusCode == 400 || ex.statusCode == 404) {
          return false;
        }
      }
      throw ex;
    }
  }

  @override
  Future<bool> isLoggedIn() async => _loggedInController.value;

  @override
  Future<bool> logOut() {
    throw new UnimplementedError();
  }
}
