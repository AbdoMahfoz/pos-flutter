import 'package:flutter/material.dart';

import 'DefaultFloatingActionButton.dart';
import 'FilledTextField.dart';

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
            child: FilledTextField(onTextChanged: onTextChanged),
          ),
        ),
      ),
      body: SafeArea(child: this.child),
      floatingActionButton: DefaultFloatingActionButton(),
    );
  }
}

