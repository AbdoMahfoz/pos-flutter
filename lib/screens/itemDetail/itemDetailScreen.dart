import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultAppBarScaffold.dart';
import 'package:posapp/common/ImageCarousel.dart';
import 'package:posapp/common/PrimaryButton.dart';
import 'package:posapp/viewmodels/itemDetailViewModel.dart';

class ItemDetailArguments {
  final int itemId;

  ItemDetailArguments({required this.itemId});
}

class ItemDetailScreen extends ScreenWidget {
  ItemDetailScreen(BuildContext context) : super(context);

  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  final Map<String, String> fields = {
    "النوع": "إطارات السيارات",
    "الماركة": "Mitsubishi Lancer",
    "الضمان": "3 سنوات",
    "متوفر": "63 قطعة حالياً"
  };

  @override
  ItemDetailScreenState createState() => ItemDetailScreenState(context);
}

class ItemDetailScreenState extends BaseStateArgumentObject<ItemDetailScreen,
    ItemDetailViewModel, ItemDetailArguments> {
  ItemDetailScreenState(BuildContext context)
      : super(() => ItemDetailViewModel(context));

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: 'منتج رقم ${args.itemId + 1}',
        useDefaultFab: false,
        backgroundColor: Colors.white,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ImageCarousel(
              aspectRatio: 1.8,
              images: widget.imgList.map((img) => Image.network(img)).toList(),
              autoSlide: false,
              brightness: Brightness.light,
            ),
            Container(
              decoration: BoxDecoration(color: Colors.grey[300]),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "إطارات السيارات للسيارات السيارة",
                            style: TextStyle(fontSize: 18, shadows: [
                              Shadow(color: Colors.grey, blurRadius: 1)
                            ]),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Toyo Tyre & Rubber",
                            style: TextStyle(fontSize: 18, shadows: [
                              Shadow(color: Colors.grey, blurRadius: 1)
                            ]),
                          )
                        ],
                      ),
                      IconButton(
                          padding: const EdgeInsets.all(0),
                          onPressed: () {},
                          icon: Icon(
                            Icons.add_circle_outlined,
                            size: 40,
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    left: 5,
                    child: Column(
                      children: [
                        Icon(Icons.two_wheeler, size: 80),
                        Text(
                          "10000 جنيه",
                          style: TextStyle(shadows: [
                            Shadow(color: Colors.grey, blurRadius: 1)
                          ], fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(children: [
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children:
                                  (widget.fields.keys.toList()..add("التقييم"))
                                      .map((e) => Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(0, 5, 8, 0),
                                            child: Text(
                                              "$e : ",
                                              textAlign: TextAlign.start,
                                              textDirection: TextDirection.rtl,
                                              style: TextStyle(
                                                  shadows: [
                                                    Shadow(
                                                        color: Colors.grey,
                                                        blurRadius: 1)
                                                  ],
                                                  fontFamily: "Segoe UI",
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ))
                                      .toList()),
                          Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: widget.fields.values
                                  .map((e) => Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 0),
                                        child: Text(
                                          e,
                                          textAlign: TextAlign.end,
                                          textDirection: TextDirection.rtl,
                                          style: TextStyle(
                                              shadows: [
                                                Shadow(
                                                    color: Colors.grey,
                                                    blurRadius: 1)
                                              ],
                                              fontFamily: "Segoe UI",
                                              fontSize: 18),
                                        ),
                                      ))
                                  .cast<Widget>()
                                  .toList()
                                    ..add(Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: Row(
                                        children: [
                                          for (int i = 0; i < 4; i++)
                                            Icon(Icons.star),
                                          Icon(Icons.star_border)
                                        ],
                                      ),
                                    ))),
                        ]),
                        SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: PrimaryButton(
                onPressed: () {},
                text: "شراء الأن",
                noPadding: true,
                isDark: true,
              ),
            ),
            SizedBox(height: 5),
            PrimaryButton(
              onPressed: () {},
              text: "أضف إلى العربة",
              noPadding: true,
              disableBorderRadius: true,
            ),
          ],
        ));
  }
}
