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

  final List<String> itemImgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
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
    if (kIsWeb || Platform.isAndroid || Platform.isIOS) {
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
          image: Icon(Icons.card_membership, size: 50),
          price: 1000,
          availableQuantity: 70,
          guaranteeYears: 5,
          rating: 4),
      new CarItem(
          name: "المنتج الثانى",
          type: "التصنيف الاول",
          model: carModel,
          isNew: true,
          image: Icon(Icons.card_membership, size: 50),
          price: 1000,
          availableQuantity: 70,
          guaranteeYears: 5,
          rating: 4),
      new CarItem(
          name: "المنتج الثالث",
          type: "التصنيف الثانى",
          model: carModel,
          isNew: true,
          image: Icon(Icons.card_membership, size: 50),
          price: 1000,
          availableQuantity: 70,
          guaranteeYears: 5,
          rating: 4),
      new CarItem(
          name: "المنتج الرابع",
          type: "التصنيف الثانى",
          model: carModel,
          isNew: true,
          image: Icon(Icons.card_membership, size: 50),
          price: 1000,
          availableQuantity: 70,
          guaranteeYears: 5,
          rating: 4),
      new CarItem(
          name: "المنتج الخامس",
          type: "التصنيف الاول",
          model: carModel,
          isNew: false,
          image: Icon(Icons.card_membership, size: 50),
          price: 1000,
          availableQuantity: 70,
          guaranteeYears: 5,
          rating: 4),
    ];
  }

  @override
  Future<List<Widget>> getItemImages(CarItem item) async {
    await Future.delayed(const Duration(seconds: 3));
    return itemImgList
        .map((img) => Image.network(
              img,
              loadingBuilder: (context, img, progress) {
                if (progress == null){
                  return img;
                }
                return Center(child: CircularProgressIndicator());
              },
            ))
        .toList();
  }
}
