import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:posapp/common/BaseStateObject.dart';
import 'package:posapp/common/LabeledCheckbox.dart';
import 'package:posapp/common/PrimaryButton.dart';
import 'package:posapp/common/PrimaryTextField.dart';
import 'package:posapp/viewmodels/login.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => new LoginScreenState();
}

class LoginScreenState extends BaseStateObject<LoginScreen, LoginViewModel> {
  bool isLoading = false;
  String username = "";
  String password = "";
  bool isLoginErred = false;
  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    viewModel = new LoginViewModel(context);
    viewModel.moveToHomeScreen.listen((_) {
      Fluttertoast.showToast(msg: "Moving to home screen");
    });
    viewModel.moveToRegisterScreen.listen((_) {
      Fluttertoast.showToast(msg: "Moving to register screen");
    });
    viewModel.loginErred.listen((val) => setState(() => isLoginErred = val));
  }

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
                    if (this.isLoginErred) ...[
                      SizedBox(height: 10),
                      Text(
                        "هنالك خطأ فى إسم المستخدم أو كلمة المرور",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: Colors.red),
                        textAlign: TextAlign.center,
                      )
                    ],
                    SizedBox(height: 20),
                    StreamBuilder<bool>(
                      stream: viewModel.isLoggingIn,
                      initialData: false,
                      builder: (context, snapshot) {
                        return PrimaryTextField(
                            label: "البريد الإلكترونى",
                            valueDirection: TextDirection.ltr,
                            onChanged: (val) => setState(() {
                                  if (!val.contains('0')) username = val;
                                }),
                            value: this.username,
                            enabled: !snapshot.data!);
                      }
                    ),
                    SizedBox(height: 10),
                    StreamBuilder<bool>(
                      stream: viewModel.isLoggingIn,
                      initialData: false,
                      builder: (context, snapshot) {
                        return PrimaryTextField(
                          label: "كلمة السر",
                          valueDirection: TextDirection.ltr,
                          onChanged: (val) => setState(() => password = val),
                          isPassword: true,
                          value: this.password,
                          enabled: !snapshot.data!,
                        );
                      }
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
                    StreamBuilder<bool>(
                      stream: viewModel.isLoggingIn,
                      initialData: false,
                      builder: (context, snapshot) {
                        return LabeledCheckbox(
                            label: "تذكرنى؟",
                            onChange: (val) =>
                                setState(() => this.rememberMe = val!),
                            value: this.rememberMe,
                            enabled: !snapshot.data!);
                      }
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    StreamBuilder<bool>(
                        stream: viewModel.isLoggingIn,
                        initialData: false,
                        builder: (context, snapshot) {
                          return PrimaryButton(
                            onPressed: () => viewModel.logIn(
                                this.username, this.password, this.rememberMe),
                            text: "تسجيل الدخول",
                            isLoading: snapshot.data!,
                          );
                        }),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 10),
                      child: Divider(color: Colors.white, height: 3),
                    ),
                    SizedBox(height: 10),
                    StreamBuilder<bool>(
                        stream: viewModel.isLoggingIn,
                        initialData: false,
                        builder: (context, snapshot) {
                          return PrimaryButton(
                              onPressed: () => viewModel.register(),
                              text: "الإشتراك",
                              enabled: !snapshot.data!);
                        })
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
