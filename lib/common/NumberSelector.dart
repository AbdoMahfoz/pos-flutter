import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NumberSelector extends StatefulWidget {
  final int? value;
  final void Function(int) onChange;

  NumberSelector({this.value, required this.onChange});

  @override
  _NumberSelectorState createState() => _NumberSelectorState();
}

class _NumberSelectorState extends State<NumberSelector> {
  late TextEditingController controller;
  int editingValue = 1;

  @override
  void initState() {
    super.initState();
    controller = new TextEditingController();
    editingValue = widget.value ?? 1;
    controller.value = TextEditingValue(text: editingValue.toString());
  }

  void onFocusChanged(bool isFocused) {
    if (!isFocused) {
      editingValue = min(9999, max(1, editingValue));
      controller.value = TextEditingValue(text: editingValue.toString());
      widget.onChange(editingValue);
    }
  }

  void onTextChanged(String newVal) {
    int? res = int.tryParse(newVal);
    int offset = 0;
    if (newVal != "") {
      if (res == null) {
        offset = max(controller.selection.base.offset - 1, 0);
      } else {
        offset = controller.selection.base.offset;
        editingValue = min(9999, max(0, res));
      }
    } else {
      editingValue = 0;
    }
    controller.value = TextEditingValue(
        text: (newVal == "") ? "" : editingValue.toString(),
        selection: TextSelection.fromPosition(TextPosition(offset: offset)));
  }

  void onButtonClicked(bool add) {
    editingValue = min(9999, max(editingValue + (add ? 1 : -1), 1));
    controller.value = TextEditingValue(text: editingValue.toString());
    widget.onChange(editingValue);
  }

  @override
  void didUpdateWidget(covariant NumberSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != null &&
        widget.value != editingValue) {
      editingValue = widget.value!;
      controller.value = TextEditingValue(text: editingValue.toString());
    }
  }

  Widget smallButton(String inner, bool leftRadius, void Function() onClick) =>
      Container(
        width: 30,
        height: 27,
        decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.horizontal(
                left: leftRadius ? Radius.circular(8) : Radius.zero,
                right: leftRadius ? Radius.zero : Radius.circular(8)),
            border: Border.all(color: Colors.black, width: 1)),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            radius: 5.0,
            onTap: onClick,
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, -4),
                child: Text(
                  inner,
                  style: TextStyle(color: Colors.black, fontSize: 25),
                ),
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        smallButton("+", false, () => this.onButtonClicked(true)),
        Container(
          width: 60,
          height: 27,
          child: Focus(
            onFocusChange: this.onFocusChanged,
            child: TextField(
              enableInteractiveSelection: false,
              textAlignVertical: TextAlignVertical.center,
              scrollPadding: EdgeInsets.zero,
              maxLines: 1,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 13),
              scrollPhysics: ScrollPhysics(),
              textAlign: TextAlign.center,
              controller: this.controller,
              onChanged: this.onTextChanged,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      borderRadius: BorderRadius.circular(0))),
            ),
          ),
        ),
        smallButton("-", true, () => this.onButtonClicked(false))
      ],
    );
  }
}
