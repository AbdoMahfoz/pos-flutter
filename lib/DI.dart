import 'package:injector/injector.dart';
import 'logic/interfaces/IAuth.dart';
import 'logic/stubs/AuthStub.dart';

void __setStubs() {
  final injector = Injector.appInstance;
  injector.registerSingleton<IAuth>(() => AuthStub());
}

void __setRealDependencies() {
  final injector = Injector.appInstance;
  injector.registerSingleton<IAuth>(() => AuthStub());
}

void setDependecies() {
  __setRealDependencies();
}
