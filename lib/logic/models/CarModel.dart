import 'package:flutter/material.dart';

class CarModel {
  final String name;
  final int id;
  final Widget image;
  final Widget imageSmall;

  CarModel(
      {required this.name,
      required this.id,
      required this.image,
      required this.imageSmall});
}
