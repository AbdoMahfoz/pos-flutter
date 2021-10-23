import 'CarItem.dart';

class CartItem {
  final int id;
  final CarItem item;
  final int quantity;

  CartItem({required this.item, required this.quantity, required this.id});
}
