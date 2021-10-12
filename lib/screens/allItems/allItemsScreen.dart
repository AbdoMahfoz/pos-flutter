import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultSearchAppBar.dart';
import 'package:posapp/viewmodels/allItemsViewModel.dart';

class AllItemsScreenArguments {
  final int itemId;

  AllItemsScreenArguments({required this.itemId});
}

class AllItemsScreen extends ScreenWidget {
  AllItemsScreen(BuildContext context) : super(context);

  @override
  AllItemsScreenState createState() => AllItemsScreenState(context);
}

class AllItemsScreenState extends BaseStateArgumentObject<AllItemsScreen,
    AllItemsViewModel,
    AllItemsScreenArguments> {
  AllItemsScreenState(BuildContext context)
      : super(() => AllItemsViewModel(context));

  @override
  Widget build(BuildContext context) {
    return DefaultSearchAppBar(
        child: ListView.builder(
            itemCount: 20,
            itemBuilder: (context, index) =>
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Container(
                      height: 100,
                      decoration:
                      BoxDecoration(color: Colors.white, boxShadow: [
                        BoxShadow(
                            spreadRadius: 0.5,
                            blurRadius: 5,
                            color: Colors.grey[400]!,
                            offset: Offset(0, 5))
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Icon(Icons.two_wheeler, size: 80),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "إطارات السيارات للسيارات السيارة",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontFamily: "Roboto"),
                                        ),
                                        Icon(Icons.car_repair)
                                      ],
                                    ),
                                    Text(
                                      "Toyo Tyre & Rubber",
                                      style: TextStyle(fontSize: 13),
                                    ),
                                    Flexible(child: FractionallySizedBox(
                                      heightFactor: 0.1)),
                                    RichText(
                                      text: TextSpan(
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                          children: [
                                            TextSpan(
                                                text: "نوع السيارة: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            TextSpan(text: "Mitsubishi")
                                          ]),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                              children: [
                                                TextSpan(
                                                    text: "الحالة: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                TextSpan(text: "مستعمل")
                                              ]),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 12),
                                              children: [
                                                TextSpan(
                                                    text: "جنيه ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                        FontWeight.bold)),
                                                TextSpan(text: "1800")
                                              ]),
                                        )
                                      ],
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )));
  }
}
