import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:posapp/common/HTTPImage.dart';
import 'package:posapp/logic/interfaces/IHTTP.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/logic/models/CarModel.dart';

class CoreLogic extends ILogic {
  final http = Injector.appInstance.get<IHTTP>();
  Map<int, CarModel> carModels = <int, CarModel>{};

  @override
  Future<List<Image>> getAds() async {
    return [];
  }

  @override
  Future<List<CarItem>> getCarItems(CarModel carModel, String? query) async {
    final args = Map<String, String>();
    args["CarModelId"] = carModel.id.toString();
    if (query == null) {
      args["Query"] = query!;
    }
    final res = await http.sendRequestWithResult<CarItem>(
        HTTPRequestMethod.GET, "api/Item",
        queryArgs: args);
    return res.body;
  }

  @override
  Future<List<CarModel>> getCarModels() async {
    var res = (await http.sendRequestWithResult<CarModel>(
            HTTPRequestMethod.GET, "api/Item/Models"))
        .body;
    carModels =
        Map<int, CarModel>.fromEntries(res.map((e) => MapEntry(e.id, e)));
    return res;
  }

  @override
  Future<List<Widget>> getItemImages(CarItem item) {
    final res = <Widget>[];
    for (int i = 0; i < item.imageCount; i++) {
      res.add(HTTPImage("api/Picture/item/image",
          queryArgs: {"ItemId": item.id, "Idx": i}));
    }
    return Future.value(res);
  }

  @override
  CarModel getCarModel(int id) {
    return carModels[id]!;
  }
}
