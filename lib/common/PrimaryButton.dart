import 'package:flutter/material.dart';

class PrimaryButton extends StatefulWidget {
  final void Function() onPressed;
  final Widget? child;
  final String? text;
  final bool isLoading;
  final bool enabled;

  PrimaryButton(
      {required this.onPressed,
      this.child,
      this.text,
      this.isLoading = false,
      this.enabled = true});

  @override
  PrimaryButtonState createState() => PrimaryButtonState();
}

class PrimaryButtonState extends State<PrimaryButton>
    with TickerProviderStateMixin {
  late AnimationController isLoadingAnimController;
  late AnimationController enabledAnimController;
  late Animation<double> offsetValue;
  late Animation<Color?> colorAnimation;

  @override
  void initState() {
    super.initState();
    isLoadingAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    enabledAnimController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
    offsetValue = Tween<double>(begin: 0.0, end: 50.0).animate(CurvedAnimation(
        parent: isLoadingAnimController, curve: Curves.easeInOut));
    colorAnimation = ColorTween(begin: Colors.yellow[600], end: Colors.yellow[800])
        .animate(CurvedAnimation(
            parent: enabledAnimController, curve: Curves.easeInOut));
    if (widget.isLoading) {
      isLoadingAnimController.forward();
      enabledAnimController.forward();
    } else if (!widget.enabled) {
      enabledAnimController.forward();
    }
  }

  @override
  void didUpdateWidget(covariant PrimaryButton oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading != oldWidget.isLoading ||
        widget.enabled != oldWidget.enabled) {
      if (widget.isLoading) {
        isLoadingAnimController.forward();
        enabledAnimController.forward();
      } else if (!widget.enabled) {
        enabledAnimController.forward();
      }
      if (!widget.isLoading) {
        isLoadingAnimController.reverse();
      }
      if (!widget.isLoading && widget.enabled) {
        enabledAnimController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.child == null && widget.text == null) {
      throw ArgumentError(
          "A child or text must be supplied to PrimaryButton widget");
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: AnimatedBuilder(
        animation: colorAnimation,
        builder: (context, child) => Container(
            decoration: BoxDecoration(
                color: colorAnimation.value,
                borderRadius: BorderRadius.all(const Radius.circular(8))),
            width: double.infinity,
            child: child),
        child: Material(
          color: Colors.transparent,
          child: AbsorbPointer(
            absorbing: widget.isLoading || !widget.enabled,
            child: InkWell(
                borderRadius: BorderRadius.all(const Radius.circular(8)),
                splashColor: Colors.yellow[200],
                focusColor: Colors.yellow[200],
                child: Theme(
                    data: ThemeData(
                        buttonColor: Colors.white,
                        primaryTextTheme:
                            TextTheme(headline1: TextStyle(color: Colors.white))),
                    child: Container(
                      clipBehavior: Clip.hardEdge,
                      decoration: BoxDecoration(),
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 25),
                      child: Stack(children: [
                        AnimatedBuilder(
                          animation: offsetValue,
                          builder: (context, child) => Opacity(
                            opacity: offsetValue.value / 50.0,
                            child: Transform.translate(
                                offset: Offset(
                                    0,
                                    widget.enabled
                                        ? 50.0 - offsetValue.value
                                        : 50.0),
                                child: child),
                          ),
                          child: Center(
                            child:  CircularProgressIndicator(
                                    color: Colors.black, strokeWidth: 2),
                          ),
                        ),
                        AnimatedBuilder(
                          animation: offsetValue,
                          builder: (context, child) => Opacity(
                            opacity: 1 - (offsetValue.value / 50.0),
                            child: Transform.translate(
                                offset: Offset(
                                    0, widget.enabled ? -offsetValue.value : 0),
                                child: child),
                          ),
                          child: Center(
                              child: widget.child ??
                                  Text(widget.text ?? "",
                                      style: TextStyle(
                                          color: Colors.black, fontFamily: "Jenine", fontSize: 28))),
                        ),
                      ]),
                    )),
                onTap: widget.onPressed),
          ),
        ),
      ),
    );
  }
}
