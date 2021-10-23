import 'package:flutter/material.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/logic/models/CarModel.dart';
import 'package:posapp/screens/allItems/allItemsScreen.dart';
import 'package:posapp/viewmodels/baseViewModel.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModelWithLogic<ILogic> {
  HomeViewModel(BuildContext context) : super(context){
    logic.getAds().then((value) => __ads.add(value));
    logic.getCarModels().then((value) => __carModels.add(value));
  }

  final __ads = new BehaviorSubject<List<Image>>.seeded([]);
  Stream<List<Image>> get ads => __ads.stream;

  final __carModels = new BehaviorSubject<List<CarModel>>.seeded([]);
  Stream<List<CarModel>> get carModels => __carModels.stream;

  void carModelClicked(CarModel carModel) {
    Navigator.pushNamed(context, '/allItems',
        arguments: AllItemsScreenArguments(carModel: carModel));
  }

  void profileIconClicked() {
    throw new UnimplementedError();
  }

  @override
  void onClose() {
    super.onClose();
    __ads.close();
    __carModels.close();
  }
}
