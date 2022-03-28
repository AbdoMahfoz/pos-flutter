import 'package:data_table_2/data_table_2.dart';
import "package:flutter/material.dart";
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/FilledTextField.dart';
import 'package:posapp/logic/models/CarItem.dart';
import 'package:posapp/viewmodels/web/webMainViewModel.dart';
import 'modal.dart';

class WebMainScreen extends ScreenWidget {
  WebMainScreen(BuildContext context) : super(context);

  @override
  WebMainScreenState createState() => WebMainScreenState(context);
}

class WebMainScreenState
    extends BaseStateObject<WebMainScreen, WebMainViewModel>
    with SingleTickerProviderStateMixin {
  WebMainScreenState(BuildContext context)
      : super(() => WebMainViewModel(context));

  bool modalVisible = false;
  final scrollController = ScrollController();

  void revealModal(CarItem item) async {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (context) =>
            Modal(exitCallback: () => Navigator.pop(context)));
  }

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(fontWeight: FontWeight.bold);

    return Flex(
      direction: Axis.vertical,
      children: [
        Container(
          width: double.infinity,
          color: Colors.grey[800],
          child: Column(
            children: [
              SizedBox(height: 30),
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Text("All Items",
                      style:
                          TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 50.0, vertical: 20.0),
                child: FilledTextField(
                  onTextChanged: (newVal) {},
                  fontSize: 30,
                  hintText: "Search",
                  fillColor: Colors.grey[700]!,
                  hoverColor: Colors.grey[600]!,
                  focusColor: Colors.grey[600]!,
                  textColor: Colors.white,
                  borderRadius: 35,
                  innerPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 20),
                ),
              )
            ],
          ),
        ),
        Flexible(
          child: StreamBuilder<List<CarItem>>(
              stream: viewModel.items,
              builder: (context, snapshot) {
                if (snapshot.data == null) return CircularProgressIndicator();
                return DataTable2(
                    showCheckboxColumn: true,
                    decoration: BoxDecoration(
                        color: Colors.black54,
                        border: Border.symmetric(
                            horizontal: BorderSide(
                                color: Theme.of(context).backgroundColor,
                                width: 1))),
                    border: TableBorder.symmetric(
                        inside: BorderSide(color: Colors.grey, width: 1)),
                    checkboxHorizontalMargin: 10,
                    scrollController: this.scrollController,
                    columns: [
                      DataColumn2(
                          size: ColumnSize.L,
                          label: Text(
                            "Name",
                            style: headerStyle,
                          )),
                      DataColumn2(
                          size: ColumnSize.S,
                          label: Text("Quantity", style: headerStyle),
                          numeric: true),
                      DataColumn2(
                          size: ColumnSize.M,
                          label: Text("Category", style: headerStyle)),
                      DataColumn2(
                          size: ColumnSize.M,
                          label: Text("Car model", style: headerStyle)),
                      DataColumn2(
                          size: ColumnSize.S,
                          label: Text("Condition", style: headerStyle)),
                      DataColumn2(
                          size: ColumnSize.S,
                          label: Text(
                            "Actions",
                            style: headerStyle,
                          ))
                    ],
                    rows: (snapshot.data ?? [])
                        .map((item) => DataRow2(cells: [
                              DataCell(Text(item.name)),
                              DataCell(Text(item.quantity.toString())),
                              DataCell(Text(item.categoryName)),
                              DataCell(Text(item.model.name)),
                              DataCell(Text(item.isNew ? "New" : "Old",
                                  style: TextStyle(
                                      color: item.isNew
                                          ? Colors.green
                                          : Colors.red))),
                              DataCell(Row(
                                children: [
                                  IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () => this.revealModal(item),
                                      color: Colors.white),
                                  SizedBox(width: 10),
                                  IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {},
                                      color: Colors.white)
                                ],
                              ))
                            ]))
                        .toList());
              }),
        )
      ],
    );
  }
}
