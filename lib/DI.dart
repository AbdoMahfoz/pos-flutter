import 'package:injector/injector.dart';
import 'package:posapp/logic/interfaces/IHomeLogic.dart';
import 'package:posapp/logic/stubs/HomeLogicStub.dart';
import 'logic/interfaces/IAuth.dart';
import 'logic/stubs/AuthStub.dart';

void __setStubs() {
  final injector = Injector.appInstance;
  injector.registerSingleton<IAuth>(() => AuthStub());
  injector.registerSingleton<IHomeLogic>(() => HomeLogicStub());
}

void __setRealDependencies() {
  final injector = Injector.appInstance;
}

void setDependecies() {
  __setStubs();
}
