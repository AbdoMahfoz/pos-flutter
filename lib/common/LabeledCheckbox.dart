import "package:flutter/material.dart";

class LabeledCheckbox extends StatelessWidget {
  final String? label;
  final void Function(bool?) onChange;
  final bool value;
  final bool enabled;
  final Color enabledColor;
  final Color disabledColor;

  const LabeledCheckbox(
      {Key? key,
      this.enabled = true,
      required this.value,
      this.label,
      this.enabledColor = Colors.white,
      this.disabledColor = Colors.white38,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = MaterialStateColor.resolveWith(this.enabled
        ? (states) => this.enabledColor
        : (states) => this.disabledColor);
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 0,
          children: [
            if (this.label != null)
              Transform.translate(
                  offset: const Offset(15, 0),
                  child: Text(
                    this.label!,
                    style: Theme.of(context).textTheme.bodyText1,
                  )),
            AbsorbPointer(
              absorbing: !this.enabled,
              child: Checkbox(
                value: this.value,
                onChanged: this.onChange,
                fillColor: color,
                checkColor:
                    MaterialStateColor.resolveWith((states) => Colors.black),
                activeColor: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
