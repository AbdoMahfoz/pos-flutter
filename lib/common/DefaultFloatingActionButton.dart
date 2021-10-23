import 'package:flutter/material.dart';

class DefaultFloatingActionButton extends StatelessWidget {
  const DefaultFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add_shopping_cart, color: Colors.black),
      onPressed: () => Navigator.pushNamed(context, '/cart'),
      backgroundColor: Colors.yellow,
    );
  }
}