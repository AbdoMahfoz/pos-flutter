import 'dart:async';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:posapp/logic/interfaces/IAuth.dart';
import 'package:posapp/viewmodels/mobile/baseViewModel.dart';
import 'package:rxdart/rxdart.dart';

class LoginViewModel extends BaseViewModel {
  IAuth auth = Injector.appInstance.get<IAuth>();

  BehaviorSubject<bool> __isLoggingIn = new BehaviorSubject<bool>.seeded(false);

  Stream<bool> get isLoggingIn => __isLoggingIn.stream;

  StreamController<void> __moveToHomeScreen =
      new StreamController<void>.broadcast();

  Stream<void> get moveToHomeScreen => __moveToHomeScreen.stream;

  StreamController<void> __moveToRegisterScreen =
      new StreamController<void>.broadcast();

  Stream<void> get moveToRegisterScreen => __moveToRegisterScreen.stream;

  BehaviorSubject<bool> __loginErred = new BehaviorSubject<bool>.seeded(false);

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
    } catch (ex) {
      networkErrorController.add(null);
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
