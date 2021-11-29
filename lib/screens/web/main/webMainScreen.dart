import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:posapp/common/BaseWidgets.dart';
import 'package:posapp/viewmodels/web/webMainViewModel.dart';
import 'package:rxdart/rxdart.dart';
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

  final scrollController = ScrollController();
  late AnimationController modalSwitchController;
  late Animation<double> darkenAnimation;
  final modalVisibleStream = BehaviorSubject<bool>.seeded(false);
  final duration = Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    modalSwitchController =
        AnimationController(vsync: this, duration: this.duration);
    darkenAnimation = Tween<double>(begin: 0.0, end: 0.7).animate(
        CurvedAnimation(
            parent: modalSwitchController, curve: Curves.easeInOut));
  }

  void showModal() {
    modalVisibleStream.add(true);
    modalSwitchController.forward();
  }

  void hideModal() {
    modalVisibleStream.add(false);
    modalSwitchController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final headerStyle = Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(fontWeight: FontWeight.bold);
    return Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Stack(children: [
          AnimatedBuilder(
            animation: darkenAnimation,
            child: ItemList(
                scrollController: scrollController,
                headerStyle: headerStyle,
                revealModal: this.showModal),
            builder: (context, child) => AbsorbPointer(
              absorbing: darkenAnimation.isCompleted,
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                    Color.fromRGBO(0, 0, 0, darkenAnimation.value),
                    BlendMode.darken),
                child: child,
              ),
            ),
          ),
          AnimatedSwitcher(
              duration: this.duration,
              switchOutCurve: Curves.easeInOut,
              switchInCurve: Curves.easeInOut,
              child: StreamBuilder<bool>(
                  stream: this.modalVisibleStream,
                  builder: (context, snapshot) => (snapshot.data ?? false)
                      ? Stack(children: [
                          GestureDetector(
                              onTap: this.hideModal,
                              child: Container(color: Colors.transparent)),
                          Modal(exitCallback: this.hideModal)
                        ])
                      : Center())),
        ]));
  }
}
