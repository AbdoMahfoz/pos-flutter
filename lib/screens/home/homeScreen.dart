import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultFloatingActionButton.dart';
import 'package:posapp/screens/allItems/allItemsScreen.dart';
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

  void gridItemClicked(int itemId) {
    Navigator.pushNamed(context, '/allItems',
        arguments: AllItemsScreenArguments(itemId: itemId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الرئيسية",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          IconButton(
            iconSize: 35.0,
            icon: Icon(Icons.account_circle_rounded),
            onPressed: () {},
          )
        ],
        brightness: Brightness.dark,
      ),
      floatingActionButton: DefaultFloatingActionButton(),
      body: Flex(
        direction: Axis.vertical,
        children: [
          CarouselHeader(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text("أختر نوع السيارة",
                style: Theme.of(context).textTheme.headline3),
          ),
          CarModelGrid(onItemClicked: this.gridItemClicked)
        ],
      ),
    );
  }
}
