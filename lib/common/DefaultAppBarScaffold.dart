import 'package:flutter/material.dart';

class DefaultAppBarScaffold extends StatelessWidget {
  final Widget child;
  final String title;

  DefaultAppBarScaffold({required this.child, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text(this.title, style: Theme.of(context).textTheme.headline2),
          centerTitle: true,
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          brightness: Brightness.dark,
        ),
        body: SafeArea(child: this.child));
  }
}
