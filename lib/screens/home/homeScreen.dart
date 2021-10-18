import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultFloatingActionButton.dart';
import 'package:posapp/logic/models/CarModel.dart';
import 'package:posapp/viewmodels/homeViewModel.dart';

import 'carModelGrid.dart';
import 'carouselHeader.dart';

class HomeScreen extends ScreenWidget {
  HomeScreen(BuildContext context) : super(context);

  @override
  HomeScreenState createState() => HomeScreenState(context);
}

class HomeScreenState extends BaseStateObject<HomeScreen, HomeViewModel> {
  HomeScreenState(BuildContext context) : super(() => HomeViewModel(context));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الرئيسية",
          style: Theme
              .of(context)
              .textTheme
              .headline3,
        ),
        actions: [
          IconButton(
            iconSize: 35.0,
            icon: Icon(Icons.account_circle_rounded),
            onPressed: viewModel.profileIconClicked,
          )
        ],
        brightness: Brightness.dark,
      ),
      floatingActionButton: DefaultFloatingActionButton(),
      body: Flex(
        direction: Axis.vertical,
        children: [
          StreamBuilder<List<Image>>(
              stream: viewModel.ads,
              builder: (context, snapshot) {
                return AnimatedSwitcher(
                  duration: const Duration(seconds: 1),
                  child: (snapshot.data != null && snapshot.data!.length > 0)
                      ? CarouselHeader(images: snapshot.data!)
                      : SizedBox(height: 0),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeOut,
                  transitionBuilder: (child, animation) =>
                      SizeTransition(
                          sizeFactor: animation,
                          child: child,
                          axis: Axis.vertical),
                  layoutBuilder: (child, _) => child!,
                );
              }),
          StreamBuilder<List<Image>>(
              stream: viewModel.ads,
              builder: (context, snapshot) {
                return Padding(
                  padding: EdgeInsets.fromLTRB(
                      0, (snapshot.data?.length ?? 0) == 0 ? 15 : 0, 0, 15),
                  child: Text("أختر نوع السيارة",
                      style: Theme
                          .of(context)
                          .textTheme
                          .headline3),
                );
              }),
          StreamBuilder<List<CarModel>>(
              stream: viewModel.carModels,
              builder: (context, snapshot) {
                return CarModelGrid(
                  onItemClicked: (clickedModel) =>
                      viewModel.carModelClicked(clickedModel),
                  carModels: snapshot.data ?? [],
                );
              })
        ],
      ),
    );
  }
}
