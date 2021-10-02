import 'dart:async';

import 'package:posapp/logic/interfaces/IValues.dart';
import 'package:injector/injector.dart';

class HomeViewModel {
  IValues values = Injector.appInstance.get<IValues>();

  int __counterVal = 0;
  final __counterStream = new StreamController<int>();
  Stream<int> get counter => __counterStream.stream;

  final __valuesStream = new StreamController<List<String>>();
  Stream<List<String>> get valuesStream => __valuesStream.stream;

  addButtonClicked() async {
    __counterVal++;
    __counterStream.add(__counterVal);
    __valuesStream.add(values.getItems());
  }
}
