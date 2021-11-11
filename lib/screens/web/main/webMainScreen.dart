import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/FilledTextField.dart';
import 'package:posapp/common/LabeledCheckbox.dart';
import 'package:posapp/viewmodels/web/webMainViewModel.dart';

class WebMainScreen extends ScreenWidget {
  WebMainScreen(BuildContext context) : super(context);

  @override
  WebMainScreenState createState() => WebMainScreenState(context);
}

class WebMainScreenState
    extends BaseStateObject<WebMainScreen, WebMainViewModel> {
  WebMainScreenState(BuildContext context)
      : super(() => WebMainViewModel(context));

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Flex(
        direction: Axis.vertical,
        children: [
          Container(
            width: double.infinity,
            color: Colors.grey[800],
            child: Column(
              children: [
                SizedBox(height: 30),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Text("All Items",
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 20.0),
                  child: FilledTextField(
                    onTextChanged: (newVal) {},
                    fontSize: 30,
                    hintText: "Search",
                    fillColor: Colors.grey[700]!,
                    textColor: Colors.white,
                    borderRadius: 35,
                    innerPadding:
                        EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                  ),
                )
              ],
            ),
          ),
          Flexible(
            child: Scrollbar(
              isAlwaysShown: true,
              controller: this.scrollController,
              interactive: true,
              showTrackOnHover: true,
              thickness: 10,
              child: ListView.builder(
                controller: this.scrollController,
                itemCount: 200,
                itemBuilder: (context, index) => Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      border: Border.symmetric(
                          horizontal: BorderSide(
                              color: Theme.of(context).backgroundColor,
                              width: 1))),
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      LabeledCheckbox(
                          value: (index % 2) == 0,
                          enabledColor: Colors.grey,
                          disabledColor: Colors.grey[700]!,
                          onChange: (newVal) {}),
                      Text("Item name"),
                      SizedBox(width: 20),
                      Text("500")
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
