import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultAppBarScaffold.dart';
import 'package:posapp/common/ImageCarousel.dart';
import 'package:posapp/common/PrimaryButton.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/viewmodels/itemDetailViewModel.dart';

class ItemDetailArguments {
  final CarItem carItem;

  ItemDetailArguments({required this.carItem});
}

class ItemDetailScreen extends ScreenWidget {
  ItemDetailScreen(BuildContext context) : super(context);

  @override
  ItemDetailScreenState createState() => ItemDetailScreenState(context);
}

class ItemDetailScreenState extends BaseStateArgumentObject<ItemDetailScreen,
    ItemDetailViewModel, ItemDetailArguments> {
  ItemDetailScreenState(BuildContext context)
      : super(() => ItemDetailViewModel(context));

  @override
  Widget build(BuildContext context) {
    final Map<String, String> fields = {
      "النوع": args.carItem.type,
      "الماركة": args.carItem.model.name,
      "الضمان": "${args.carItem.guaranteeYears} سنوات",
      "متوفر": "${args.carItem.availableQuantity} قطعة حالياً"
    };
    final bodyText1 = Theme.of(context)
        .textTheme
        .bodyText1!
        .copyWith(color: Colors.black, fontFamily: "Almarai");
    final bodyText2 = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(fontFamily: 'Almarai', fontSize: 20);
    return DefaultAppBarScaffold(
        title: args.carItem.name,
        useDefaultFab: false,
        backgroundColor: Colors.white,
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.share))],
        child: Flex(
          direction: Axis.vertical,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            StreamBuilder<List<Widget>>(
                stream: viewModel.itemImages,
                builder: (context, snapshot) {
                  return ImageCarousel(
                    aspectRatio: 1.8,
                    images:
                        (snapshot.data == null || snapshot.data!.length == 0)
                            ? [Center(child: CircularProgressIndicator())]
                            : snapshot.data!,
                    autoSlide: false,
                    brightness: Brightness.light,
                  );
                }),
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
                          Text(args.carItem.name,
                              style: bodyText1.copyWith(shadows: [
                                Shadow(color: Colors.grey, blurRadius: 1)
                              ])),
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
                        args.carItem.model.image,
                        Text(
                          "${args.carItem.price} جنيه",
                          style: bodyText1.copyWith(shadows: [
                            Shadow(color: Colors.grey, blurRadius: 1)
                          ], fontSize: 25, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                  ),
                  Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Table(
                          defaultColumnWidth: IntrinsicColumnWidth(),
                          columnWidths: {2: FlexColumnWidth(5)},
                          children: fields.entries
                              .map((element) => TableRow(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 0, 0, 8),
                                        child: Text(
                                          element.key,
                                          textAlign: TextAlign.right,
                                          style: bodyText2.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Text(" : ${element.value}",
                                          style: bodyText2),
                                      Container()
                                    ],
                                  ))
                              .toList()
                                ..add(TableRow(children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 8),
                                    child: Text(
                                      "التقييم",
                                      textAlign: TextAlign.right,
                                      style: bodyText2.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(" : ", style: bodyText2),
                                      for (int i = 1; i <= 5; i++)
                                        if (i <= args.carItem.rating)
                                          Icon(Icons.star)
                                        else
                                          Icon(Icons.star_border)
                                    ],
                                  ),
                                  Container()
                                ])),
                        ),
                      ),
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
