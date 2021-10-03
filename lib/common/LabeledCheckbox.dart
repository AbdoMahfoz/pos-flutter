import "package:flutter/material.dart";

class LabeledCheckbox extends StatelessWidget {
  final String label;
  final void Function(bool?) onChange;

  const LabeledCheckbox({Key? key, required this.label, required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            Checkbox(
              value: false,
              onChanged: this.onChange,
              fillColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              checkColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
              activeColor:
                  MaterialStateColor.resolveWith((states) => Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
