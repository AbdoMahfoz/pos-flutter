import 'package:posapp/logic/interfaces/IValues.dart';

class Values implements IValues {
  @override
  List<String> getItems() {
    return <String>["Item1", "Item2", "Item3", "Item4", "Item5"];
  }
}
