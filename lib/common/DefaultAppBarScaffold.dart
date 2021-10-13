import 'package:flutter/material.dart';
import 'package:posapp/common/DefaultFloatingActionButton.dart';

class DefaultAppBarScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final bool useDefaultFab;
  final Color? backgroundColor;

  DefaultAppBarScaffold(
      {required this.title,
      required this.child,
      this.useDefaultFab = false,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          this.backgroundColor ?? Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text(this.title, style: Theme.of(context).textTheme.headline3),
        centerTitle: true,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        brightness: Brightness.dark,
      ),
      body: SafeArea(child: this.child),
      floatingActionButton:
          this.useDefaultFab ? DefaultFloatingActionButton() : null,
    );
  }
}
