import 'package:flutter/material.dart';
import 'package:posapp/logic/models/CarModel.dart';

class CarItem {
  final int id;
  final String name;
  final String type;
  final CarModel model;
  final bool isNew;
  final Widget image;
  final double price;
  final int guaranteeYears;
  final int availableQuantity;
  final int rating;

  CarItem({
    required this.id,
    required this.name,
    required this.type,
    required this.model,
    required this.isNew,
    required this.image,
    required this.price,
    required this.guaranteeYears,
    required this.availableQuantity,
    required this.rating
  });
}
