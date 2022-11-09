import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PressedTimerWidget extends StatefulWidget {
  PressedTimerWidget(
      {Key? key,
      this.onTap,
      this.onTimePressed,
      this.onStateChanged,
      required this.duration,
      required this.child})
      : super(key: key);

  Function()? onTap;
  Function(TapDownDetails)? onTimePressed;
  Function(bool)? onStateChanged;
  final Widget child;
  final Duration duration;

  @override
  State<PressedTimerWidget> createState() => _PressedTimerWidgetState();
}

class _PressedTimerWidgetState extends State<PressedTimerWidget> {
  void onStateChanged(bool value) {
    if (widget.onStateChanged != null) {
      widget.onStateChanged!(value);
    }
  }

  @override
  Widget build(BuildContext context) {
    Timer? timer;
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: (details) {
        timer = Timer(widget.duration, () {
          if (widget.onTimePressed != null) {
            widget.onTimePressed!(details);
          }
        });
        onStateChanged(true);
      },
      onTapUp: (details) {
        timer?.cancel();
        onStateChanged(false);
      },
      onTapCancel: () {
        timer?.cancel();
        onStateChanged(false);
      },
      child: widget.child,
    );
  }
}
