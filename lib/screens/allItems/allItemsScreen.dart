import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultSearchAppBar.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CarModel.dart';
import 'package:posapp/viewmodels/allItemsViewModel.dart';

class AllItemsScreenArguments {
  final CarModel carModel;

  AllItemsScreenArguments({required this.carModel});
}

class AllItemsScreen extends ScreenWidget {
  AllItemsScreen(BuildContext context) : super(context);

  @override
  AllItemsScreenState createState() => AllItemsScreenState(context);
}

class AllItemsScreenState extends BaseStateArgumentObject<AllItemsScreen,
    AllItemsViewModel, AllItemsScreenArguments> {
  AllItemsScreenState(BuildContext context)
      : super(() => AllItemsViewModel(context));

  @override
  Widget build(BuildContext context) {
    return DefaultSearchAppBar(
        onTextChanged: (newValue) => viewModel.search(newValue),
        child: StreamBuilder<List<CarItem>>(
            stream: viewModel.carItems,
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: (snapshot.data?.length ?? 0) == 0
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final curItem = snapshot.data![index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 0.5,
                                          blurRadius: 5,
                                          color: Colors.grey[400]!,
                                          offset: Offset(0, 5))
                                    ]),
                                child: Material(
                                  child: InkWell(
                                    onTap: () => viewModel.itemClicked(curItem),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Stack(children: [
                                        Flex(
                                          direction: Axis.horizontal,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            //Icon(Icons.two_wheeler, size: 80),
                                            curItem.image,
                                            SizedBox(width: 10),
                                            Expanded(
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      curItem.name,
                                                      style: TextStyle(
                                                          fontSize: 15,
                                                          fontFamily: "Roboto"),
                                                    ),
                                                    Text(
                                                      curItem.type,
                                                      style: TextStyle(
                                                          fontSize: 15),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
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
                                                                text: curItem
                                                                    .model.name)
                                                          ]),
                                                    ),
                                                    RichText(
                                                      text: TextSpan(
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: 12),
                                                          children: [
                                                            TextSpan(
                                                                text:
                                                                    "الحالة: ",
                                                                style: TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                            TextSpan(
                                                                text: curItem
                                                                        .isNew
                                                                    ? "جديد"
                                                                    : "مستعمل",
                                                                style: TextStyle(
                                                                    color: curItem.isNew
                                                                        ? Colors
                                                                            .black
                                                                        : Colors
                                                                            .red))
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
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 12),
                                                children: [
                                                  TextSpan(
                                                      text: "جنيه ",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)),
                                                  TextSpan(
                                                      text: curItem.price
                                                          .toString())
                                                ]),
                                          ),
                                        ),
                                        Positioned(
                                            top: 1,
                                            left: 1,
                                            child: curItem.model.imageSmall),
                                      ]),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
              );
            }));
  }
}
