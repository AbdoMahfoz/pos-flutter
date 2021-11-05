import 'package:flutter/material.dart';
import 'package:posapp/viewmodels/mobile/baseViewModel.dart';

abstract class BaseStateObject<T extends StatefulWidget,
    VM extends BaseViewModel> extends State<T> {
  final VM Function() __vmFactory;
  late VM viewModel;

  BaseStateObject(this.__vmFactory);

  @override
  void initState() {
    super.initState();
    viewModel = __vmFactory();
  }

  @override
  void dispose() {
    super.dispose();
    viewModel.onClose();
  }
}

abstract class BaseStateArgumentObject<T extends StatefulWidget,
    VM extends ViewModelArgs<AT>, AT> extends BaseStateObject<T, VM> {
  AT? args;

  BaseStateArgumentObject(VM Function() _vmFactory) : super(_vmFactory);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final pushedArgs = ModalRoute.of(context)?.settings.arguments;
    if (pushedArgs != null){
      args = pushedArgs as AT;
    }
    viewModel.pushArgs(args);
  }

  @override
  void initState() {
    super.initState();

  }
}

abstract class ScreenWidget extends StatefulWidget {
  final BuildContext context;
  ScreenWidget(this.context);
}
