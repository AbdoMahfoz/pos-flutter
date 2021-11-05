import 'package:flutter/material.dart';
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/DefaultAppBarScaffold.dart';
import 'package:posapp/common/PrimaryButton.dart';
import 'package:posapp/common/PrimaryTextField.dart';
import 'package:posapp/viewmodels/mobile/registerViewModel.dart';

class RegisterScreen extends ScreenWidget {
  RegisterScreen(BuildContext context) : super(context);
  @override
  RegisterScreenState createState() => RegisterScreenState(context);
}

class RegisterScreenState
    extends BaseStateObject<RegisterScreen, RegisterViewModel> {
  RegisterScreenState(BuildContext context)
      : super(() => RegisterViewModel(context));

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "الإشتراك",
      child: Flex(
        direction: Axis.vertical,
        children: [
          Flexible(
              child: FractionallySizedBox(
            heightFactor: 0.5,
          )),
          Text(
            "برجاء إدخال البيانات التالية\nمن أجل الإشتراك",
            style: Theme.of(context).textTheme.headline2,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 15,
          ),
          PrimaryTextField(label: "البريد الإلكترونى", onChanged: (val) {}),
          SizedBox(
            height: 5,
          ),
          PrimaryTextField(label: "رقم الهاتف", onChanged: (val) {}),
          Flexible(
              child: FractionallySizedBox(
            heightFactor: 0.2,
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "سيتم التواصل معك من خلال رقم الهاتف والبريد الإلكترونى فى أقرب وقت ممكن لإتمام الإشتراك",
              style: Theme.of(context).textTheme.bodyText1,
              textAlign: TextAlign.center,
            ),
          ),
          Flexible(
              child: FractionallySizedBox(
            heightFactor: 0.3,
          )),
          PrimaryButton(
            onPressed: () {},
            text: "تسجيل بيانات الإشتراك",
          )
        ],
      ),
    );
  }
}
