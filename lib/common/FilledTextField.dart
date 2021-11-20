import 'package:flutter/material.dart';

class FilledTextField extends StatelessWidget {
  final void Function(String) onTextChanged;
  final double fontSize;
  final String hintText;
  final Color fillColor;
  final Color hoverColor;
  final Color focusColor;
  final Color textColor;
  final double borderRadius;
  final EdgeInsetsGeometry innerPadding;

  const FilledTextField(
      {Key? key,
      required this.onTextChanged,
      this.fontSize = 15,
      this.hintText = "البحث عن...",
      this.textColor = Colors.black,
      this.fillColor = Colors.white,
      this.hoverColor = Colors.white,
      this.focusColor = Colors.white,
      this.borderRadius = 8.0,
      this.innerPadding = const EdgeInsets.all(13)})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: this.onTextChanged,
      style: Theme.of(context).textTheme.bodyText2!.copyWith(
          color: this.textColor,
          decorationColor: this.fillColor,
          fontSize: this.fontSize,
          height: 1),
      decoration: InputDecoration(
          isDense: true,
          contentPadding: this.innerPadding,
          hintText: this.hintText,
          hintStyle: Theme.of(context)
              .textTheme
              .bodyText2!
              .copyWith(color: this.textColor, fontSize: this.fontSize),
          filled: true,
          fillColor: this.fillColor,
          focusColor: this.focusColor,
          hoverColor: this.hoverColor,
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: this.focusColor),
              borderRadius: BorderRadius.circular(this.borderRadius)),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: this.fillColor),
              borderRadius: BorderRadius.circular(this.borderRadius))),
    );
  }
}
