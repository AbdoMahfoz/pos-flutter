import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultAppBarScaffold.dart';
import 'package:posapp/viewmodels/homeViewModel.dart';

class HomeScreen extends ScreenWidget {
  HomeScreen(BuildContext context) : super(context);

  @override
  HomeScreenState createState() => HomeScreenState(context);
}

class HomeScreenState extends BaseStateObject<HomeScreen, HomeViewModel> {
  HomeScreenState(BuildContext context) : super(() => HomeViewModel(context));

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: "الرئيسية",
        child: Center(
          child: Text(
            "Home screen",
            style: TextStyle(color: Colors.white),
          ),
        ));
  }
}
