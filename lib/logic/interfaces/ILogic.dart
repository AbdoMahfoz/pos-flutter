import 'dart:async';
import 'package:flutter/material.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CarModel.dart';

abstract class ILogic {
  Future<List<CarModel>> getCarModels();
  Future<List<Image>> getAds();
  Future<List<CarItem>> getCarItems(CarModel carModel, String? query);
  Future<List<Widget>> getItemImages(CarItem item);
}