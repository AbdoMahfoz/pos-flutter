import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:posapp/logic/CommonExceptions.dart';
import 'package:posapp/logic/interfaces/IAuth.dart';
import 'package:posapp/viewmodels/baseViewModel.dart';

class LoginViewModel extends BaseViewModel {
  IAuth auth = Injector.appInstance.get<IAuth>();

  StreamController<bool> __isLoggingIn = new StreamController<bool>.broadcast();
  Stream<bool> get isLoggingIn => __isLoggingIn.stream;

  StreamController<void> __moveToHomeScreen =
      new StreamController<void>.broadcast();
  Stream<void> get moveToHomeScreen => __moveToHomeScreen.stream;

  StreamController<void> __moveToRegisterScreen =
      new StreamController<void>.broadcast();
  Stream<void> get moveToRegisterScreen => __moveToRegisterScreen.stream;

  StreamController<bool> __loginErred = new StreamController<bool>.broadcast();
  Stream<bool> get loginErred => __loginErred.stream;

  LoginViewModel(BuildContext context) : super(context);

  void logIn(String? username, String? password, bool rememberMe) async {
    username = username ?? "";
    password = password ?? "";
    __loginErred.add(false);
    __isLoggingIn.add(true);
    bool res = false;
    try {
      res = await auth.login(username, password);
    } on NetworkException {
      networkErrorController.add(null);
      __isLoggingIn.add(false);
      return;
    } on Exception {
      __isLoggingIn.add(false);
      return;
    }
    if (res) {
      __moveToHomeScreen.add(null);
    } else {
      __isLoggingIn.add(false);
      __loginErred.add(true);
    }
  }

  void register() {
    __moveToRegisterScreen.add(null);
  }

  @override
  void onClose() {
    super.onClose();
    __isLoggingIn.close();
    __loginErred.close();
    __moveToHomeScreen.close();
    __moveToRegisterScreen.close();
  }
}
