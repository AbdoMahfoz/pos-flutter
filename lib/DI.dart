import 'package:injector/injector.dart';
import 'package:posapp/logic/implementations/CartLogic.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/logic/stubs/LogicStub.dart';
import 'logic/interfaces/IAuth.dart';
import 'logic/interfaces/ICart.dart';
import 'logic/stubs/AuthStub.dart';

final useStubs = true;

void __setStubs() {
  final injector = Injector.appInstance;
  injector.registerSingleton<IAuth>(() => AuthStub());
  injector.registerSingleton<ILogic>(() => LogicStub());
  injector.registerSingleton<ICart>(() => CartLogic());
}

void __setRealDependencies() {
  final injector = Injector.appInstance;
  injector.registerSingleton<ICart>(() => CartLogic());
}

void setDependencies() {
  if (useStubs){
    __setStubs(); 
  } else {
    __setRealDependencies();
  }
}
