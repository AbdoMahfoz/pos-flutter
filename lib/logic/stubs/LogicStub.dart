import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CarModel.dart';

class LogicStub implements ILogic {
  final List<String> imgList = [
    'https://image.shutterstock.com/image-photo/wide-angle-panorama-autumn-forestmisty-260nw-1195159864.jpg',
    'https://image.shutterstock.com/image-photo/wide-angle-panorama-autumn-forestmisty-260nw-1195159864.jpg',
    'https://image.shutterstock.com/image-photo/wide-angle-panorama-autumn-forestmisty-260nw-1195159864.jpg',
    'https://image.shutterstock.com/image-photo/wide-angle-panorama-autumn-forestmisty-260nw-1195159864.jpg',
    'https://image.shutterstock.com/image-photo/wide-angle-panorama-autumn-forestmisty-260nw-1195159864.jpg',
    'https://image.shutterstock.com/image-photo/wide-angle-panorama-autumn-forestmisty-260nw-1195159864.jpg',
    'https://image.shutterstock.com/image-photo/wide-angle-panorama-autumn-forestmisty-260nw-1195159864.jpg',
    'https://image.shutterstock.com/image-photo/wide-angle-panorama-autumn-forestmisty-260nw-1195159864.jpg',
  ];

  @override
  Future<List<Image>> getAds() async {
    await Future.delayed(const Duration(seconds: 5));
    return imgList
        .map((imgUrl) => Image.network(
              imgUrl,
              errorBuilder: (context, object, stackTrace) =>
                  Center(child: Text("Error loading content")),
            ))
        .toList();
  }

  @override
  Future<List<CarModel>> getCarModels() async {
    await Future.delayed(const Duration(seconds: 2));
    return <CarModel>[
      new CarModel(
          name: "BMW",
          id: 1,
          image: Icon(
            Icons.card_giftcard,
            size: 70,
          ),
          imageSmall: Icon(
            Icons.card_giftcard,
          ))
    ];
  }

  @override
  Future<List<CarItem>> getCarItems(CarModel carModel, String? query) async {
    if(kIsWeb || Platform.isAndroid || Platform.isIOS){
      Fluttertoast.showToast(msg: "Initiated query \"$query\"");
    } else {
      print("Initiated query \"$query\"");
    }
    await Future.delayed(const Duration(seconds: 1));
    return <CarItem>[
      new CarItem(
          name: "المنتج الاول + $query",
          type: "التصنيف الاول",
          model: carModel,
          isNew: true,
          image: Icon(Icons.card_membership),
          price: 1000),
      new CarItem(
          name: "المنتج الثانى",
          type: "التصنيف الاول",
          model: carModel,
          isNew: true,
          image: Icon(Icons.card_membership),
          price: 1000),
      new CarItem(
          name: "المنتج الثالث",
          type: "التصنيف الثانى",
          model: carModel,
          isNew: true,
          image: Icon(Icons.card_membership),
          price: 1000),
      new CarItem(
          name: "المنتج الرابع",
          type: "التصنيف الثانى",
          model: carModel,
          isNew: true,
          image: Icon(Icons.card_membership),
          price: 1000),
      new CarItem(
          name: "المنتج الخامس",
          type: "التصنيف الاول",
          model: carModel,
          isNew: false,
          image: Icon(Icons.card_membership),
          price: 1000),
    ];
  }
}
