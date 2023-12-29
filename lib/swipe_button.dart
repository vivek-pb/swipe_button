import 'package:flutter/material.dart';

class SwipeButtonScreen extends StatefulWidget {
  const SwipeButtonScreen({super.key});

  @override
  State<SwipeButtonScreen> createState() => _SwipeButtonScreenState();
}

class _SwipeButtonScreenState extends State<SwipeButtonScreen> {
  ButtonAction _action = ButtonAction.init;

  ButtonAction get action => _action;

  set action(ButtonAction value) {
    _action = value;

    if (action == ButtonAction.loading) {
      Future.delayed(const Duration(milliseconds: 400)).then((value) {
        width = 50;
        setState(() {});
      });
    }
    setState(() {});
  }

  double _width = 250;

  double get width => _width;

  set width(double value) {
    _width = value;

    if (width == 50) {
      Future.delayed(const Duration(milliseconds: 800)).then((value) {
        action = ButtonAction.loaded;
        setState(() {});
      });
    }
    setState(() {});
  }

  double _left = 0;

  double get left => _left;

  set left(double value) {
    _left = value;

    if (left >= 190) {
      action = ButtonAction.loading;
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedContainer(
          duration: const Duration(seconds: 1),
          width: width,
          height: 50,
          padding: const EdgeInsets.all(1),
          decoration: BoxDecoration(
            color:
                action == ButtonAction.init ? Colors.red : Colors.transparent,
            borderRadius: BorderRadius.circular(24),
            border:
                action == ButtonAction.loading || action == ButtonAction.loaded
                    ? Border.all(color: Colors.red, width: 1)
                    : null,
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              if (action == ButtonAction.loaded)
                const CircularProgressIndicator(
                  color: Colors.red,
                ),
              Visibility(
                visible: action == ButtonAction.init,
                child: Positioned(
                  left: left,
                  child: GestureDetector(
                    onPanUpdate: (details) {
                      setState(() {
                        if (details.localPosition.dx > left &&
                            details.localPosition.dx >= 0 &&
                            details.localPosition.dx <= 200) {
                          left = details.localPosition.dx;
                        }
                      });
                    },
                    child: Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        color: action == ButtonAction.init
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

enum ButtonAction { init, loading, loaded }
