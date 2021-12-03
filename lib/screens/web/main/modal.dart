import 'package:flutter/material.dart';
import 'package:posapp/common/LabeledCheckbox.dart';
import 'package:posapp/common/PrimaryButton.dart';
import 'package:posapp/common/PrimaryTextField.dart';

class Modal extends StatelessWidget {
  final void Function() exitCallback;

  const Modal({Key? key, required this.exitCallback}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 500.0,
        width: 800.0,
        decoration: BoxDecoration(
            color: Color.fromRGBO(36, 33, 33, 1.0),
            borderRadius: BorderRadius.circular(25.0),
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0.3,
                  blurRadius: 5,
                  color: Colors.black,
                  offset: Offset(0, 5))
            ]),
        child: Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text("Edit item", style: Theme.of(context).textTheme.headline1),
                SizedBox(height: 10),
                PrimaryTextField(
                  label: "Name",
                  onChanged: (newName) {},
                  valueDirection: TextDirection.ltr,
                  labelDirection: TextDirection.ltr,
                ),
                PrimaryTextField(
                  label: "Quantity",
                  onChanged: (newName) {},
                  valueDirection: TextDirection.ltr,
                  labelDirection: TextDirection.ltr,
                ),
                PrimaryTextField(
                  label: "Category (Combobox)",
                  onChanged: (newName) {},
                  valueDirection: TextDirection.ltr,
                  labelDirection: TextDirection.ltr,
                ),
                PrimaryTextField(
                  label: "CarModel (Combobox)",
                  onChanged: (newName) {},
                  valueDirection: TextDirection.ltr,
                  labelDirection: TextDirection.ltr,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(4.0, 0, 0, 0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: LabeledCheckbox(
                      value: true,
                      onChange: (newVal) {},
                      label: "Is new",
                      direction: TextDirection.ltr,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                PrimaryButton(onPressed: this.exitCallback, text: "Save")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
