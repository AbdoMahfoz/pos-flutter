import 'package:flutter/material.dart';
import 'package:posapp/logic/models/CarItem.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    Key? key,
    required this.data,
    required this.onItemClicked,
    required this.textStyle,
  }) : super(key: key);

  final void Function(CarItem) onItemClicked;
  final TextStyle textStyle;
  final List<CarItem> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          final curItem = data[index];
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
                            curItem.image,
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.stretch,
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      curItem.name,
                                      style: textStyle,
                                    ),
                                    Text(
                                      curItem.type,
                                      style: textStyle,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          style:
                                          textStyle.copyWith(fontSize: 12),
                                          children: [
                                            TextSpan(
                                                text: "نوع السيارة: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                    FontWeight.bold)),
                                            TextSpan(text: curItem.model.name)
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
                                                text: curItem.isNew
                                                    ? "جديد"
                                                    : "مستعمل",
                                                style: TextStyle(
                                                    color: curItem.isNew
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
                                  TextSpan(text: curItem.price.toString())
                                ]),
                          ),
                        ),
                        Positioned(
                            top: 1, left: 1, child: curItem.model.imageSmall),
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
