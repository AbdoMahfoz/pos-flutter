import 'package:injector/injector.dart';
import 'package:posapp/logic/implementations/Auth.dart';
import 'package:posapp/logic/implementations/CartLogic.dart';
import 'package:posapp/logic/implementations/CoreLogic.dart';
import 'package:posapp/logic/implementations/HTTP.dart';
import 'package:posapp/logic/interfaces/IHTTP.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/logic/models/AuthModels.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CarModel.dart';
import 'package:posapp/logic/models/IModelFactory.dart';
import 'logic/implementations/IOHTTP.dart';
import 'logic/interfaces/IAuth.dart';
import 'logic/interfaces/ICart.dart';

final useStubs = false;

void __setModelFactories() {
  final injector = Injector.appInstance;
  injector.registerSingleton<IModelFactory<CarModel>>(() => CarModelFactory());
  injector.registerSingleton<IModelFactory<CarItem>>(() => CarItemFactory());
  injector.registerSingleton<IModelFactory<LoginResult>>(
      () => LoginResultFactory());
}

void __setStubs() {
  /*
  final injector = Injector.appInstance;
  injector.registerSingleton<IAuth>(() => AuthStub());
  injector.registerSingleton<ILogic>(() => LogicStub());
  injector.registerSingleton<ICart>(() => CartLogic());
  injector.registerSingleton<IHTTP>(() => HTTP());
  */
}

void __setRealDependencies() {
  final injector = Injector.appInstance;
  injector.registerSingleton<ICart>(() => CartLogic());
  injector.registerSingleton<IHTTP>(() => IOHTTP());
  injector.registerSingleton<IAuth>(() => Auth());
  injector.registerSingleton<ILogic>(() => CoreLogic());
}

void setDependencies() {
  if (useStubs) {
    __setStubs();
  } else {
    __setRealDependencies();
  }
  __setModelFactories();
}
