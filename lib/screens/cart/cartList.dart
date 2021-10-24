import 'package:flutter/material.dart';
import 'package:posapp/common/NumberSelector.dart';
import 'package:posapp/logic/models/CartItem.dart';

class CartList extends StatelessWidget {
  final List<CartItem> items;
  final void Function(CartItem) onItemDeleted;
  final void Function(CartItem, int) onQuantityChanged;

  CartList(
      {required this.items,
      required this.onItemDeleted,
      required this.onQuantityChanged});

  @override
  Widget build(BuildContext context) {
    final textStyle =
        Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 20);
    return AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: (items.length == 0)
            ? Center(
                child: Text(
                "عربة التسوق فارغة",
                style: textStyle.copyWith(
                    fontSize: 15, fontWeight: FontWeight.w100),
              ))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final curItem = items[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Container(
                        height: 140,
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
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Stack(children: [
                            Flex(
                                direction: Axis.vertical,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Flexible(
                                    child: Flex(
                                      direction: Axis.horizontal,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        //Icon(Icons.two_wheeler, size: 80),
                                        curItem.item.image,
                                        SizedBox(width: 10),
                                        Expanded(
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                                            text:
                                                                "نوع السيارة: ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        TextSpan(
                                                            text: curItem.item
                                                                .model.name)
                                                      ]),
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                      style: textStyle.copyWith(
                                                          fontSize: 12),
                                                      children: [
                                                        TextSpan(
                                                            text: "الحالة: ",
                                                            style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold)),
                                                        TextSpan(
                                                            text: curItem
                                                                    .item.isNew
                                                                ? "جديد"
                                                                : "مستعمل",
                                                            style: TextStyle(
                                                                color: curItem
                                                                        .item
                                                                        .isNew
                                                                    ? Colors
                                                                        .green
                                                                    : Colors
                                                                        .red))
                                                      ]),
                                                ),
                                              ]),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 5, 0, 0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            NumberSelector(
                                                value: curItem.quantity,
                                                onChange: (newNum) => this
                                                    .onQuantityChanged(
                                                        curItem, newNum)),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 8.0, 0),
                                              child: RichText(
                                                text: TextSpan(
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors.black,
                                                        fontFamily: "Almarai"),
                                                    children: [
                                                      TextSpan(
                                                          text: "متوفر : ",
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                      TextSpan(
                                                          text:
                                                              "${curItem.item.availableQuantity} قطعه")
                                                    ]),
                                              ),
                                            ),
                                          ],
                                        ),
                                        OutlinedButton(
                                            style: ButtonStyle(
                                              visualDensity:
                                                  VisualDensity.compact,
                                              padding:
                                                  MaterialStateProperty.all(
                                                      const EdgeInsets.all(
                                                          10.0)),
                                              backgroundColor:
                                                  MaterialStateProperty.all(
                                                      Colors.white),
                                              elevation:
                                                  MaterialStateProperty.all(2),
                                            ),
                                            onPressed: () =>
                                                this.onItemDeleted(curItem),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 0, 5, 0),
                                              child: Row(children: [
                                                Text(
                                                  "مسح من العربة",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2!
                                                      .copyWith(fontSize: 13),
                                                ),
                                                Icon(
                                                  Icons.delete,
                                                  color: Colors.red,
                                                  size: 20,
                                                )
                                              ]),
                                            ))
                                      ],
                                    ),
                                  )
                                ]),
                            Positioned(
                              top: 1,
                              left: 1,
                              child: RichText(
                                text: TextSpan(
                                    style: textStyle.copyWith(fontSize: 15),
                                    children: [
                                      TextSpan(
                                          text: "جنيه ",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      TextSpan(
                                          text: curItem.item.price.toString())
                                    ]),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    ),
                  );
                }));
  }
}
