import 'package:flutter/material.dart';
import 'package:posapp/viewmodels/baseViewModel.dart';

abstract class BaseStateObject<T extends StatefulWidget,
    VM extends BaseViewModel> extends State<T> {
  late VM viewModel;

  @override
  void dispose() {
    super.dispose();
    viewModel.onClose();
  }
}