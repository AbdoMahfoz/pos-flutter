import 'package:flutter/material.dart';
import 'package:posapp/logic/interfaces/IHomeLogic.dart';
import 'package:posapp/logic/models/CarModel.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeLogicStub implements IHomeLogic {
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
    return imgList.map((imgUrl) => Image.network(imgUrl)).toList();
  }

  @override
  Future<List<CarModel>> getCarModels() async {
    await Future.delayed(const Duration(seconds: 2));
    return <CarModel>[
      new CarModel(name: "BMW", id: 1, image: Icon(Icons.card_giftcard, size: 70,))
    ];
  }
}
