import 'package:flutter/material.dart';
import 'package:posapp/logic/interfaces/IAuth.dart';
import 'package:posapp/viewmodels/mobile/baseViewModel.dart';
import 'package:rxdart/rxdart.dart';

class WebLoginViewModel extends BaseViewModelWithLogic<IAuth> {
  WebLoginViewModel(BuildContext context) : super(context);

  final _isLoggingIn = BehaviorSubject<bool>.seeded(false);
  final _loginErr = BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isLoggingIn => _isLoggingIn.stream;

  Stream<bool> get loginErr => _loginErr.stream;

  void logIn(String username, String password) async {
    _isLoggingIn.add(true);
    _loginErr.add(false);
    if (await logic.login(username, password, requireAdmin: true)) {
      //TODO: Navigate to next page
    } else {
      _loginErr.add(true);
      _isLoggingIn.add(false);
    }
  }

  @override
  void onClose() {
    super.onClose();
    _isLoggingIn.close();
    _loginErr.close();
  }
}
