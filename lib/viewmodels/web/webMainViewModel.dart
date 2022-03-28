import "package:flutter/material.dart";
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/viewmodels/mobile/baseViewModel.dart';
import "package:rxdart/rxdart.dart";

class WebMainViewModel extends BaseViewModel {
  WebMainViewModel(BuildContext context) : super(context);

  var _items = new BehaviorSubject<List<CarItem>>();
  Stream<List<CarItem>> get items => _items.stream;
}
