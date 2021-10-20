import 'package:flutter/material.dart';

import 'DefaultFloatingActionButton.dart';

class DefaultSearchAppBar extends StatelessWidget {
  final Widget child;
  final void Function(String) onTextChanged;

  const DefaultSearchAppBar(
      {Key? key, required this.child, required this.onTextChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        brightness: Brightness.dark,
        title: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: TextField(
              onChanged: this.onTextChanged,
              style: TextStyle(
                  color: Colors.black,
                  decorationColor: Colors.white,
                  fontSize: 15,
                  height: 1),
              decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(13),
                  hintText: "البحث عن...",
                  hintStyle: Theme
                      .of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Colors.black, fontSize: 15),
                  filled: true,
                  fillColor: Colors.white,
                  focusColor: Colors.white,
                  hoverColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8)),
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8))),
            ),
          ),
        ),
      ),
      body: SafeArea(child: this.child),
      floatingActionButton: DefaultFloatingActionButton(),
    );
  }
}

