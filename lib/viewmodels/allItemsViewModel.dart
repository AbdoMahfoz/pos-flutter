import 'package:flutter/material.dart';
import 'package:posapp/logic/interfaces/ILogic.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/screens/allItems/allItemsScreen.dart';
import 'package:posapp/screens/itemDetail/itemDetailScreen.dart';
import 'package:posapp/viewmodels/baseViewModel.dart';
import 'package:rxdart/rxdart.dart';
import 'package:mutex/mutex.dart';

class AllItemsViewModel
    extends BaseViewModelWithLogicAndArgs<ILogic, AllItemsScreenArguments> {
  AllItemsViewModel(BuildContext context) : super(context);

  final __carItems = new BehaviorSubject<List<CarItem>>.seeded([]);
  DateTime? __searchSnapshot;
  final __snapshotMutex = new Mutex();
  final __searchActiveMutex = new Mutex();
  List<CarItem>? __allItemsResult;
  bool abortQuery = true;

  Stream<List<CarItem>> get carItems => __carItems.stream;

  @override
  void onArgsPushed() async {
    final searchResults = await logic.getCarItems(args.carModel, null);
    __allItemsResult = searchResults;
    __carItems.add(searchResults);
  }

  void search(String query) async {
    // Mark that we should abort any active query
    if(query == ""){
      abortQuery = true;
      __carItems.add(__allItemsResult!);
    } else {
      abortQuery = false;
    }
    // Make sure that no active search operations are currently running
    await __searchActiveMutex.acquire();
    __searchActiveMutex.release();
    // Set search time snapshot to now
    await __snapshotMutex.acquire();
    __searchSnapshot = DateTime.now();
    __snapshotMutex.release();
    // Wait for 300 milliseconds
    await Future.delayed(const Duration(milliseconds: 300));
    // Check if the difference between the last snapshot and now is >= 300
    // if true, this means we are the last query, we may then proceed with the search
    // Otherwise, we are no the last query, we then just abort and let that last query run
    await __snapshotMutex.acquire();
    if (DateTime.now().millisecondsSinceEpoch -
            __searchSnapshot!.millisecondsSinceEpoch >=
        300) {
      __snapshotMutex.release();
      // Initiate search, let others now that search is active
      await __searchActiveMutex.acquire();
      // If the use aborted the search, we should return the full list of items
      if (query == "" || abortQuery) {
        __carItems.add(__allItemsResult!);
        __searchActiveMutex.release();
      } else {
        // Perform search through the API
        if(abortQuery){
          __searchActiveMutex.release();
          return;
        }
        __carItems.add([]);
        final searchResults = await logic.getCarItems(args.carModel, query);
        if(abortQuery){
          __carItems.add(__allItemsResult!);
          __searchActiveMutex.release();
          return;
        }
        __carItems.add(searchResults);
        __searchActiveMutex.release();
      }
    } else {
      __snapshotMutex.release();
    }
  }

  void itemClicked(CarItem item) {
    Navigator.pushNamed(context, '/itemDetail',
        arguments: ItemDetailArguments(carItem: item));
  }

  @override
  void onClose() {
    super.onClose();
    __carItems.close();
  }
}
