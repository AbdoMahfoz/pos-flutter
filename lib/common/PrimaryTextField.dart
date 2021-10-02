import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  final String label;
  final TextDirection valueDirection;
  final TextDirection labelDirection;
  final void Function(String) onChanged;
  final bool isPassword;

  const PrimaryTextField(
      {Key? key,
      required this.label,
      this.valueDirection = TextDirection.rtl,
      this.labelDirection = TextDirection.rtl,
      this.isPassword = false,
      required this.onChanged})
      : super(key: key);

  @override
  _PrimaryTextFieldState createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool isTextRevealed = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 5),
      child: Directionality(
        textDirection: this.widget.labelDirection,
        child: TextField(
          obscureText: this.widget.isPassword && !this.isTextRevealed,
          enableSuggestions: !this.widget.isPassword,
          autocorrect: !this.widget.isPassword,
          onChanged: this.widget.onChanged,
          textDirection: this.widget.valueDirection,
          style: TextStyle(color: Colors.white, decorationColor: Colors.white),
          decoration: InputDecoration(
              suffixIcon: !this.widget.isPassword
                  ? null
                  : IconButton(
                      onPressed: () => setState(() {
                        isTextRevealed = !isTextRevealed;
                      }),
                      icon: Icon(
                          this.isTextRevealed
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.white),
                    ),
              labelText: this.widget.label,
              hintTextDirection: TextDirection.rtl,
              fillColor: Colors.white,
              focusColor: Colors.white,
              labelStyle: TextStyle(
                  color: Colors.white, fontFamily: "Jenine", fontSize: 21),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(5))),
        ),
      ),
    );
  }
}