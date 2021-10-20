import 'package:flutter/material.dart';
import 'package:posapp/logic/models/CarModel.dart';

class CarItem {
  final String name;
  final String type;
  final CarModel model;
  final bool isNew;
  final Widget image;
  final double price;

  CarItem({
    required this.name,
    required this.type,
    required this.model,
    required this.isNew,
    required this.image,
    required this.price,
  });
}
