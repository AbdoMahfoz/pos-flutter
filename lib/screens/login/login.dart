import 'package:flutter/material.dart';
import 'package:posapp/common/PrimaryTextField.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: Color.fromARGB(255, 51, 51, 67),
        child: Center(
          child: Column(
            children: [
              SizedBox(height: 100),
              RichText(
                  text: TextSpan(
                      children: [
                    TextSpan(text: "مرحباً "),
                    TextSpan(text: "بك", style: TextStyle(color: Colors.yellow))
                  ],
                      style: const TextStyle(
                          fontFamily: "Jenine",
                          fontSize: 60,
                          color: Colors.white))),
              SizedBox(height: 10),
              Text("برجاء إدخال بياناتك لتسجيل دخولك",
                  style: const TextStyle(
                      fontFamily: "Jenine", fontSize: 30, color: Colors.white)),
              SizedBox(height: 20),
              PrimaryTextField(
                label: "البريد الإلكترونى",
                valueDirection: TextDirection.ltr,
                onChanged: (val) {},
              ),
              SizedBox(height: 10),
              PrimaryTextField(
                label: "كلمة السر",
                valueDirection: TextDirection.ltr,
                onChanged: (val) {},
                isPassword: true,
              )
            ],
          ),
        ),
      )),
    );
  }
}
