import 'package:injector/injector.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/logic/stubs/LogicStub.dart';
import 'logic/interfaces/IAuth.dart';
import 'logic/stubs/AuthStub.dart';

void __setStubs() {
  final injector = Injector.appInstance;
  injector.registerSingleton<IAuth>(() => AuthStub());
  injector.registerSingleton<ILogic>(() => LogicStub());
}

void __setRealDependencies() {

}

void setDependecies() {
  __setStubs();
}
