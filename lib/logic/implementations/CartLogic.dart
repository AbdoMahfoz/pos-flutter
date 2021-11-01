import 'dart:math';

import 'package:posapp/logic/interfaces/ICart.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CartItem.dart';
import 'package:rxdart/rxdart.dart';

class CartLogic extends ICart {
  final __cart = <CartItem>[];
  final __cartStream = new BehaviorSubject<List<CartItem>>.seeded([]);

  @override
  void addItemToCart(CarItem item, int quantity) {
    int indx = __cart.indexWhere((element) => element.item.id == item.id);
    if (indx == -1) {
      __cart.add(CartItem(item: item, quantity: quantity, id: __cart.length));
      __cartStream.add(List.from(__cart));
    }
  }

  @override
  Future<Stream<List<CartItem>>> getCartItemsOfUser() async =>
      __cartStream.stream;

  @override
  void removeItemFromCart(CartItem item) {
    __cart.removeWhere((element) => element.item.id == item.item.id);
    __cartStream.add(List.from(__cart));
  }

  @override
  void updateItemQuantity(CartItem item, int newQuantity) {
    newQuantity = min(item.item.quantity, newQuantity);
    int idx = __cart.indexWhere((element) => element.item.id == item.item.id);
    __cart[idx] =
        CartItem(item: item.item, quantity: newQuantity, id: item.id);
    __cartStream.add(List.from(__cart));
  }
}
