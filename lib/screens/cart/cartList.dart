import 'package:flutter/material.dart';
import 'package:posapp/logic/models/CartItem.dart';

class CartList extends StatelessWidget {
  final List<CartItem> items;
  final void Function(CartItem) onItemClicked;

  CartList({required this.items, required this.onItemClicked});

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20);
    if (items.length == 0) {
      return Center(
          child: Text(
        "لا يوجد مشتريات بسلة المشتريات",
        style: textStyle.copyWith(fontSize: 15, fontWeight: FontWeight.w100),
      ));
    }
    return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final curItem = items[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: 100,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.3,
                          blurRadius: 5,
                          color: Colors.grey[400]!,
                          offset: Offset(0, 5))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () => this.onItemClicked(curItem),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Stack(children: [
                        Flex(
                          direction: Axis.horizontal,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            //Icon(Icons.two_wheeler, size: 80),
                            curItem.item.image,
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      curItem.item.name,
                                      style: textStyle,
                                    ),
                                    Text(
                                      curItem.item.type,
                                      style: textStyle,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style: textStyle.copyWith(
                                              fontSize: 12),
                                          children: [
                                            TextSpan(
                                                text: "نوع السيارة: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: curItem.item.model.name)
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style:
                                              textStyle.copyWith(fontSize: 12),
                                          children: [
                                            TextSpan(
                                                text: "الحالة: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            TextSpan(
                                                text: curItem.item.isNew
                                                    ? "جديد"
                                                    : "مستعمل",
                                                style: TextStyle(
                                                    color: curItem.item.isNew
                                                        ? Colors.green
                                                        : Colors.red))
                                          ]),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                        Positioned(
                          bottom: 1,
                          left: 1,
                          child: RichText(
                            text: TextSpan(
                                style: textStyle.copyWith(fontSize: 15),
                                children: [
                                  TextSpan(
                                      text: "جنيه ",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  TextSpan(text: curItem.item.price.toString())
                                ]),
                          ),
                        ),
                        Positioned(
                            top: 1,
                            left: 1,
                            child: curItem.item.model.imageSmall),
                      ]),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
