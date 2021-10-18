import 'dart:async';
import 'package:flutter/material.dart';
import 'package:posapp/logic/models/CarModel.dart';

abstract class IHomeLogic {
  Future<List<CarModel>> getCarModels();
  Future<List<Image>> getAds();
}