import "package:flutter/material.dart";
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/common/ModalScreen.dart';
import 'package:posapp/viewmodels/web/webMainViewModel.dart';
import 'itemList.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: ModalScreen(
          child:
              ItemList(revealModal: () => setState(() => modalVisible = true)),
          modal:
              Modal(exitCallback: () => setState(() => modalVisible = false)),
          isModalVisible: this.modalVisible,
          visibilityChanged: (newVal) => setState(() => modalVisible = newVal),
        ));
  }
}
