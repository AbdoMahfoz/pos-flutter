import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/PrimaryButton.dart';
import 'package:posapp/common/PrimaryTextField.dart';
import 'package:posapp/viewmodels/web/webLoginViewModel.dart';

class WebLoginScreen extends ScreenWidget {
  WebLoginScreen(BuildContext context) : super(context);

  @override
  WebLoginState createState() => WebLoginState(context);
}

class WebLoginState extends BaseStateObject<WebLoginScreen, WebLoginViewModel> {
  bool isLoginErred = false;
  String username = "";
  String password = "";

  WebLoginState(BuildContext context) : super(() => WebLoginViewModel(context));

  @override
  void initState() {
    super.initState();
    viewModel.loginErr.listen((newVal) {
      if (isLoginErred != newVal) {
        setState(() {
          isLoginErred = newVal;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: Center(
        child: Container(
          constraints: BoxConstraints.tightFor(width: 500),
          decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,
              borderRadius: BorderRadius.all(Radius.circular(25.0)),
              boxShadow: [
                BoxShadow(
                    spreadRadius: 5,
                    blurRadius: 15,
                    color: Colors.black54,
                    offset: Offset(0, 5))
              ]),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 10),
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
                    }),
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
                    }),
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
                SizedBox(
                  height: 30,
                ),
                StreamBuilder<bool>(
                    stream: viewModel.isLoggingIn,
                    initialData: false,
                    builder: (context, snapshot) {
                      return PrimaryButton(
                        onPressed: () =>
                            viewModel.logIn(this.username, this.password),
                        text: "تسجيل الدخول",
                        isLoading: snapshot.data!,
                      );
                    }),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
