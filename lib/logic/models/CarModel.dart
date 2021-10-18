import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CarModel {
  final String name;
  final int id;
  final SvgPicture image;

  CarModel({required this.name, required this.id, required this.image});
}
