import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:posapp/common/HTTPImage.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/logic/models/CarModel.dart';
import 'package:posapp/logic/models/IModelFactory.dart';

class CarItem implements IJsonSerializable {
  final int id;
  final String name;
  final String categoryName;
  final CarModel model;
  final bool isNew;
  final Widget image;
  final double price;
  final int guaranteeYears;
  final int quantity;
  final int imageCount;
  final double discount;

  CarItem(
      {required this.id,
      required this.name,
      required this.categoryName,
      required this.model,
      required this.isNew,
      required this.image,
      required this.price,
      required this.guaranteeYears,
      required this.quantity,
      required this.discount,
      required this.imageCount});

  @override
  Map<String, dynamic> toJson() {
    throw new UnimplementedError();
  }
}

class CarItemFactory extends IModelFactory<CarItem> {
  @override
  CarItem fromJson(Map<String, dynamic> jsonMap) {
    final logic = Injector.appInstance.get<ILogic>();
    return CarItem(
        id: jsonMap["id"],
        name: jsonMap["name"],
        categoryName: jsonMap["categoryName"],
        model: logic.getCarModel(jsonMap["carModelId"]),
        isNew: jsonMap["isNew"],
        image: HTTPImage(
          "api/Picture/item/icon",
          queryArgs: {"ItemId": jsonMap["id"]},
          width: 50,
          height: 50,
        ),
        price: jsonMap["price"],
        guaranteeYears: jsonMap["guaranteeYears"],
        quantity: jsonMap["quantity"],
        discount: jsonMap["discount"],
        imageCount: jsonMap["imageCount"]);
  }
}
