import 'package:posapp/logic/interfaces/ICart.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CartItem.dart';
import 'package:rxdart/rxdart.dart';

class CartLogic extends ICart {
  final __cart = <CartItem>[];
  final __cartStream = new BehaviorSubject<List<CartItem>>.seeded([]);

  @override
  void addItemToCart(CarItem item, int quantity) {
    __cart.add(CartItem(item: item, quantity: quantity, id: __cart.length));
    __cartStream.add(__cart);
  }

  @override
  Future<Stream<List<CartItem>>> getCartItemsOfUser() async =>
      __cartStream.stream;

  @override
  void removeItemFromCart(CartItem item) {
    __cart.removeAt(item.id);
    __cartStream.add(__cart);
  }

  @override
  void updateItemQuantity(CartItem item, int newQuantity) {
    __cart[item.id] =
        CartItem(item: item.item, quantity: newQuantity, id: item.id);
    __cartStream.add(__cart);
  }
}
