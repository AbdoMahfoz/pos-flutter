import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultSearchAppBar.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CarModel.dart';
import 'package:posapp/viewmodels/mobile/allItemsViewModel.dart';

import 'itemList.dart';

class AllItemsScreenArguments {
  final CarModel carModel;

  AllItemsScreenArguments({required this.carModel});
}

class AllItemsScreen extends ScreenWidget {
  AllItemsScreen(BuildContext context) : super(context);

  @override
  AllItemsScreenState createState() => AllItemsScreenState(context);
}

class AllItemsScreenState extends BaseStateArgumentObject<AllItemsScreen,
    AllItemsViewModel, AllItemsScreenArguments> {
  AllItemsScreenState(BuildContext context)
      : super(() => AllItemsViewModel(context));

  @override
  Widget build(BuildContext context) {
    final bodyText2 = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(fontFamily: 'Almarai', fontSize: 17, color: Colors.black);
    return DefaultSearchAppBar(
        onTextChanged: (newValue) => viewModel.search(newValue),
        child: StreamBuilder<List<CarItem>>(
            stream: viewModel.carItems,
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: (snapshot.data?.length ?? 0) == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ItemList(
                        data: snapshot.data!,
                        onItemClicked: viewModel.itemClicked,
                        textStyle: bodyText2),
              );
            }));
  }
}

