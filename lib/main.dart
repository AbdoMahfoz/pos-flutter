import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:posapp/DI.dart';
import 'package:posapp/screens/allItems/allItemsScreen.dart';
import 'package:posapp/screens/home/homeScreen.dart';
import 'package:posapp/screens/itemDetail/itemDetailScreen.dart';
import 'package:posapp/screens/login/loginScreen.dart';
import 'package:posapp/screens/register/registerScreen.dart';

void main() {
  setDependecies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final backgroundColor = Color.fromARGB(255, 51, 51, 67);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: backgroundColor));
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primarySwatch: Colors.blue,
          backgroundColor: backgroundColor,
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromARGB(255, 61, 61, 77)),
          textTheme: TextTheme(
              bodyText1: const TextStyle(
                  color: Colors.white, fontSize: 20, fontFamily: "Jenine"),
              headline1: const TextStyle(
                  fontFamily: "Jenine", fontSize: 60, color: Colors.white),
              headline2: const TextStyle(
                  fontFamily: "Jenine", fontSize: 30, color: Colors.white),
              headline3: const TextStyle(
                  fontFamily: "Jenine", fontSize: 30, color: Colors.yellow))),
      routes: {
        '/': (context) => LoginScreen(context),
        '/login': (context) => LoginScreen(context),
        '/register': (context) => RegisterScreen(context),
        '/home': (context) => HomeScreen(context),
        '/allItems': (context) => AllItemsScreen(context),
        '/itemDetail': (context) => ItemDetailScreen(context)
      },
    );
  }
}
