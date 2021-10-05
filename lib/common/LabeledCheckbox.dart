import "package:flutter/material.dart";

class LabeledCheckbox extends StatelessWidget {
  final String label;
  final void Function(bool?) onChange;
  final bool value;
  final bool enabled;

  const LabeledCheckbox(
      {Key? key,
      this.enabled = true,
      required this.value,
      required this.label,
      required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var color = MaterialStateColor.resolveWith(
        this.enabled ? (states) => Colors.white : (states) => Colors.white38);
    return Container(
      width: double.maxFinite,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Wrap(
          alignment: WrapAlignment.end,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 0,
          children: [
            Transform.translate(
                offset: const Offset(15, 0),
                child: Text(
                  this.label,
                  style: Theme.of(context).textTheme.bodyText1,
                )),
            AbsorbPointer(
              absorbing: !this.enabled,
              child: Checkbox(
                value: this.value,
                onChanged: this.onChange,
                fillColor: color,
                checkColor: MaterialStateColor.resolveWith((states) => Colors.black),
                activeColor: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
