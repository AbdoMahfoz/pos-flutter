import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posapp/DI.dart';
import 'package:posapp/screens/mobile/allItems/allItemsScreen.dart';
import 'package:posapp/screens/mobile/cart/cartScreen.dart';
import 'package:posapp/screens/mobile/home/homeScreen.dart';
import 'package:posapp/screens/mobile/itemDetail/itemDetailScreen.dart';
import 'package:posapp/screens/mobile/login/loginScreen.dart';
import 'package:posapp/screens/mobile/register/registerScreen.dart';
import 'package:posapp/screens/web/login/webLoginScreen.dart';
import 'package:posapp/screens/web/main/webMainScreen.dart';

void main() {
  setDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final backgroundColor = Color.fromARGB(255, 51, 51, 67);

  Widget mobileBuild(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: backgroundColor));
    return MaterialApp(
      title: 'Posapp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: backgroundColor,
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromARGB(255, 61, 61, 77)),
          textTheme: TextTheme(
            bodyText1: const TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: "Jenine"),
            bodyText2: const TextStyle(
                color: Colors.black, fontSize: 20, fontFamily: "Almarai"),
            headline1: const TextStyle(
                fontFamily: "Jenine", fontSize: 60, color: Colors.white),
            headline2: const TextStyle(
                fontFamily: "Jenine", fontSize: 30, color: Colors.white),
            headline3: const TextStyle(
                fontFamily: "Jenine", fontSize: 30, color: Colors.yellow),
          )),
      routes: {
        '/': (context) => LoginScreen(context),
        '/login': (context) => LoginScreen(context),
        '/register': (context) => RegisterScreen(context),
        '/home': (context) => HomeScreen(context),
        '/allItems': (context) => AllItemsScreen(context),
        '/itemDetail': (context) => ItemDetailScreen(context),
        '/cart': (context) => CartScreen(context)
      },
    );
  }

  Widget webBuild(BuildContext context) {
    return MaterialApp(
      title: 'Admin panel',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: backgroundColor,
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromARGB(255, 61, 61, 77)),
          textTheme: TextTheme(
            bodyText1: const TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: "Jenine"),
            bodyText2: const TextStyle(
                color: Colors.white, fontSize: 20, fontFamily: "Almarai"),
            headline1: const TextStyle(
                fontFamily: "Jenine", fontSize: 60, color: Colors.white),
            headline2: const TextStyle(
                fontFamily: "Jenine", fontSize: 30, color: Colors.white),
            headline3: const TextStyle(
                fontFamily: "Jenine", fontSize: 30, color: Colors.yellow),
          )),
      routes: {
        '/': (context) => WebMainScreen(context),
        '/login': (context) => WebLoginScreen(context),
        '/main': (context) => WebMainScreen(context)
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return (kIsWeb ||
            Platform.isLinux ||
            Platform.isWindows ||
            Platform.isMacOS)
        ? webBuild(context)
        : mobileBuild(context);
  }
}
