import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/FilledTextField.dart';
import 'package:posapp/viewmodels/web/webMainViewModel.dart';

class WebMainScreen extends ScreenWidget {
  WebMainScreen(BuildContext context) : super(context);

  @override
  WebMainScreenState createState() => WebMainScreenState(context);
}

class WebMainScreenState
    extends BaseStateObject<WebMainScreen, WebMainViewModel> {
  WebMainScreenState(BuildContext context)
      : super(() => WebMainViewModel(context));

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(fontWeight: FontWeight.bold);
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Flex(
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
                        style: TextStyle(
                            fontSize: 50, fontWeight: FontWeight.bold)),
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
            child: DataTable2(
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
                      size: ColumnSize.S,
                      label: Text("Car model", style: headerStyle)),
                  DataColumn2(
                      size: ColumnSize.S,
                      label: Text("Condition", style: headerStyle)),
                ],
                rows: List<DataRow2>.generate(
                    20,
                    (index) => DataRow2(cells: [
                          DataCell(Text("Item name")),
                          DataCell(Text("500")),
                          DataCell(Text("Category name")),
                          DataCell(Text("Car model name")),
                          DataCell(Text("Is new",
                              style: TextStyle(color: Colors.green)))
                        ]))),
          )
        ],
      ),
    );
  }
}
