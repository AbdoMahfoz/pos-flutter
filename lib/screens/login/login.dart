import 'package:flutter/material.dart';
import 'package:posapp/common/LabeledCheckbox.dart';
import 'package:posapp/common/PrimaryButton.dart';
import 'package:posapp/common/PrimaryTextField.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 51, 51, 67),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Flex(
              direction: Axis.vertical,
              children: [
                Flexible(
                  child: FractionallySizedBox(
                    heightFactor: 0.2,
                  ),
                ),
                Column(
                  children: [
                    RichText(
                        text: TextSpan(children: [
                      TextSpan(text: "مرحباً "),
                      TextSpan(
                          text: "بك", style: TextStyle(color: Colors.yellow))
                    ], style: Theme.of(context).textTheme.headline1)),
                    SizedBox(height: 10),
                    Text("برجاء إدخال بياناتك لتسجيل دخولك",
                        style: Theme.of(context).textTheme.headline2),
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
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 15),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "نسيت كلمة المرور؟",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(color: Colors.blue[200]),
                        ),
                      ),
                    ),
                    LabeledCheckbox(label: "تذكرنى؟", onChange: (_) {}),
                    SizedBox(
                      height: 30,
                    ),
                    PrimaryButton(
                      onPressed: () => setState(() {
                        this.isLoading = !this.isLoading;
                      }),
                      text: "تسجيل الدخول",
                      isLoading: this.isLoading,
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Divider(color: Colors.white, height: 2),
                    ),
                    SizedBox(height: 10),
                    PrimaryButton(
                        onPressed: () => setState(() {
                              this.isLoading = !this.isLoading;
                            }),
                        text: "الإشتراك")
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
