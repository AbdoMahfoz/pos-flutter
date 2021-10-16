import 'package:flutter/material.dart';
import 'package:posapp/common/DefaultFloatingActionButton.dart';

class DefaultAppBarScaffold extends StatelessWidget {
  final Widget child;
  final String title;
  final bool useDefaultFab;
  final Color? backgroundColor;
  final List<Widget>? actions;

  DefaultAppBarScaffold(
      {required this.title,
      required this.child,
      this.useDefaultFab = false,
      this.backgroundColor,
      this.actions});

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
        actions: this.actions,
      ),
      body: SafeArea(child: this.child),
      floatingActionButton:
          this.useDefaultFab ? DefaultFloatingActionButton() : null,
    );
  }
}
