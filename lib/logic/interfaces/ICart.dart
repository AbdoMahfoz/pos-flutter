import 'dart:async';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CartItem.dart';

abstract class ICart {
  Future<Stream<List<CartItem>>> getCartItemsOfUser();
  void addItemToCart(CarItem item, int quantity);
  void updateItemQuantity(CartItem item, int newQuantity);
  void removeItemFromCart(CartItem item);
}
