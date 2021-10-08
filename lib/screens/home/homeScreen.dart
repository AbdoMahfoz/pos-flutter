import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/screens/home/adCarousel.dart';
import 'package:posapp/viewmodels/homeViewModel.dart';

class HomeScreen extends ScreenWidget {
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  HomeScreen(BuildContext context) : super(context);

  @override
  HomeScreenState createState() => HomeScreenState(context);
}

class HomeScreenState extends BaseStateObject<HomeScreen, HomeViewModel> {
  HomeScreenState(BuildContext context) : super(() => HomeViewModel(context));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "الرئيسية",
          style: Theme.of(context).textTheme.headline3,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.account_circle_rounded),
            onPressed: () {},
          )
        ],
        brightness: Brightness.dark,
      ),
      body: Flex(
        direction: Axis.vertical,
        children: [
          SizedBox(
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 100,
                width: double.maxFinite,
                child: AdCarousel(
                  images: widget.imgList
                      .map((item) => Image.network(
                            item,
                            fit: BoxFit.cover,
                            width: 1000.0,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              final progress =
                                  loadingProgress.expectedTotalBytes == null
                                      ? null
                                      : loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!;
                              return Center(
                                child:
                                    CircularProgressIndicator(value: progress),
                              );
                            },
                          ))
                      .toList(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Text("أختر نوع السيارة",
                style: Theme.of(context).textTheme.headline3),
          ),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
            child: GridView.builder(
              scrollDirection: Axis.vertical,
              padding: EdgeInsets.all(20),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, crossAxisSpacing: 20, mainAxisSpacing: 20),
              itemCount: 20,
              itemBuilder: (BuildContext context, int index) => Container(
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 0.5,
                          blurRadius: 5,
                          color: Colors.grey[400]!,
                          offset: Offset(0, 5))
                    ],
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    border: Border.all(color: Colors.grey, width: 1)),
                child: Center(
                    child: Icon(
                  Icons.car_rental,
                  size: 75,
                )),
              ),
            ),
          ))
        ],
      ),
    );
  }
}
