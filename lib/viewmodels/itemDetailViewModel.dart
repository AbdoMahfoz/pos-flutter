import 'package:flutter/material.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/screens/cart/cartScreen.dart';
import 'package:posapp/screens/itemDetail/itemDetailScreen.dart';
import 'package:posapp/viewmodels/baseViewModel.dart';
import 'package:rxdart/rxdart.dart';

class ItemDetailViewModel
    extends BaseViewModelWithLogicAndArgs<ILogic, ItemDetailArguments> {
  ItemDetailViewModel(BuildContext context) : super(context);

  final __itemImages = new BehaviorSubject<List<Widget>>.seeded([]);

  Stream<List<Widget>> get itemImages => __itemImages.stream;

  void addItemToCart() {
    Navigator.pushNamed(context, '/cart',
        arguments: CartScreenArguments(addedItem: args!.carItem, quantity: 1));
  }

  @override
  void onArgsPushed() async {
    __itemImages.add(await logic.getItemImages(args!.carItem));
  }

  @override
  void onClose() {
    super.onClose();
    __itemImages.close();
  }
}
