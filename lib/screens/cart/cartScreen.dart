import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultAppBarScaffold.dart';
import 'package:posapp/common/PrimaryButton.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CartItem.dart';
import 'package:posapp/screens/cart/cartList.dart';
import 'package:posapp/viewmodels/cartViewModel.dart';

class CartScreenArguments {
  final CarItem addedItem;
  final int quantity;

  CartScreenArguments({required this.addedItem, required this.quantity});
}

class CartScreen extends ScreenWidget {
  CartScreen(BuildContext context) : super(context);

  @override
  CartScreenState createState() => CartScreenState(context);
}

class CartScreenState extends BaseStateArgumentObject<CartScreen, CartViewModel,
    CartScreenArguments> {
  CartScreenState(BuildContext context) : super(() => CartViewModel(context));

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        backgroundColor: Colors.white,
        title: "عربة التسوق",
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
                child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: StreamBuilder<List<CartItem>>(
                  stream: viewModel.cartItems,
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return CartList(
                      items: snapshot.data!,
                      onItemClicked: (item) {},
                    );
                  }),
            )),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
              child: PrimaryButton(
                onPressed: () {},
                text: "إستكمال عملية الشراء",
                noPadding: true,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(27)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder<double>(
                          stream: viewModel.total,
                          initialData: 0,
                          builder: (context, snapshot) {
                            return Text.rich(TextSpan(
                                children: [
                                  TextSpan(
                                      text: "الإجمالى ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(fontSize: 35)),
                                  TextSpan(
                                      text: snapshot.data!.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontSize: 25,
                                              color: Colors.white)),
                                  TextSpan(
                                      text: " جنيه",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              fontWeight: FontWeight.w100,
                                              fontSize: 17,
                                              color: Colors.white))
                                ],
                                style: TextStyle(
                                    fontFamily: "Jenine",
                                    color: Colors.white)));
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      Text("يرجى العلم بأن المبلغ الإجمالى شامل مصاريف الشحن",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white))
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
