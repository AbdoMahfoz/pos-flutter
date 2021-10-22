import 'package:flutter/material.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/screens/itemDetail/itemDetailScreen.dart';
import 'package:posapp/viewmodels/baseViewModel.dart';

class ItemDetailViewModel
    extends BaseViewModelWithLogicAndArgs<ILogic, ItemDetailArguments> {
  ItemDetailViewModel(BuildContext context) : super(context);

  @override
  void onArgsPushed() {

  }
}
