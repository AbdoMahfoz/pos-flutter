import 'package:flutter/material.dart';
import 'package:posapp/screens/login/login.dart';
import 'package:injector/injector.dart';
import 'logic/implementations/Values.dart';
import 'logic/interfaces/IValues.dart';

void main() {
  final injector = Injector.appInstance;
  injector.registerSingleton<IValues>(() => Values());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
              bodyText1: const TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: "Jenine"),
              headline1: const TextStyle(
                  fontFamily: "Jenine", fontSize: 60, color: Colors.white),
              headline2: const TextStyle(
                  fontFamily: "Jenine", fontSize: 30, color: Colors.white))),
      home: LoginScreen(),
    );
  }
}
