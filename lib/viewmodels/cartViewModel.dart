import 'dart:async';
import 'package:flutter/material.dart';
import 'package:posapp/logic/interfaces/ICart.dart';
import 'package:posapp/logic/models/CartItem.dart';
import 'package:posapp/screens/cart/cartScreen.dart';
import 'package:posapp/viewmodels/baseViewModel.dart';
import 'package:rxdart/rxdart.dart';

class CartViewModel
    extends BaseViewModelWithLogicAndArgs<ICart, CartScreenArguments> {
  CartViewModel(BuildContext context) : super(context);

  final __cartItems = new BehaviorSubject<List<CartItem>>();
  final __total = new BehaviorSubject<double>.seeded(0);

  Stream<List<CartItem>> get cartItems => __cartItems.stream;

  Stream<double> get total => __total.stream;

  late StreamSubscription<List<CartItem>> __itemTotalListener;

  @override
  void onArgsPushed() async {
    if (args != null) {
      logic.addItemToCart(args!.addedItem, args!.quantity);
    }
    final itemStream = await logic.getCartItemsOfUser();
    __itemTotalListener = itemStream.listen((data) {
      double sum = 0;
      for(var e in data) {
        sum += e.item.price * e.quantity;
      }
      __total.add(sum);
      __cartItems.add(data);
    });
  }

  void onItemDeleted(CartItem item){
    logic.removeItemFromCart(item);
  }

  void onQuantityChanged(CartItem item, int newQuantity){
    logic.updateItemQuantity(item, newQuantity);
  }

  @override
  void onClose() {
    super.onClose();
    __itemTotalListener.cancel();
    __total.close();
    __cartItems.close();
  }
}
