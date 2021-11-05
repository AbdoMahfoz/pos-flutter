import 'dart:async';

import 'package:injector/injector.dart';
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
    http.setJWToken(res.body![0].token);
    tokenRenewal = Future.delayed(
        Duration(minutes: res.body![0].expiresIn - 1), () => _tokenRefresh());
    if (_loggedInController.value == false) {
      _loggedInController.add(true);
    }
    return true;
  }

  void _tokenRefresh() async {
    var res = await http.rpost<LoginResult>('api/Account/RefreshToken');
    if (res.statusCode != 200) {
      if (_loggedInController.value != false) {
        _loggedInController.add(false);
      }
      return;
    }
    _processToken(res);
  }

  @override
  Future<bool> login(String username, String password,
      {bool requireAdmin = false}) async {
    var res = await http.rpost<LoginResult>('api/Account/Token', body: {
      "username": username,
      "password": password,
      "admin": requireAdmin
    });
    if (res.statusCode == 400 || res.statusCode == 404) {
      return false;
    }
    return _processToken(res);
  }

  @override
  Future<bool> isLoggedIn() async => _loggedInController.value;

  @override
  Future<bool> logOut() {
    throw new UnimplementedError();
  }
}
