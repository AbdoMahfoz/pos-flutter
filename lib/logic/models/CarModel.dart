import 'package:flutter/material.dart';
import 'package:posapp/common/HTTPImage.dart';
import 'package:posapp/logic/models/IModelFactory.dart';

class CarModel extends IJsonSerializable {
  final String name;
  final int id;
  final Widget image;
  final Widget imageSmall;

  CarModel(
      {required this.name,
      required this.id,
      required this.image,
      required this.imageSmall});

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}

class CarModelFactory extends IModelFactory<CarModel> {
  @override
  CarModel fromJson(Map<String, dynamic> jsonMap) {
    var img = HTTPImage(
      "api/Picture/model/icon",
      key: Key("carModel" + jsonMap["id"].toString()),
      queryArgs: {"carModelId": jsonMap["id"]},
      width: 70,
      height: 70,
    );
    return CarModel(
        name: jsonMap["name"],
        id: jsonMap["id"],
        image: img,
        imageSmall: Transform.scale(
          scale: 0.5,
          alignment: Alignment.center,
          child: img,
        ));
  }
}
