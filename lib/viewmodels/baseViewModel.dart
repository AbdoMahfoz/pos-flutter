import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BaseViewModel {
  final BuildContext context;

  @protected
  StreamController<void> networkErrorController = new StreamController<void>.broadcast();
  Stream<void> get networkError => networkErrorController.stream;

  BaseViewModel(this.context) {
    networkError.listen((event) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "هنالك مشكلة فى الإتصال بالأنترنت، الرجاء المحاولة مرة أخرى")));
    });
  }

  @mustCallSuper
  void onClose() {
    networkErrorController.close();
  }
}
