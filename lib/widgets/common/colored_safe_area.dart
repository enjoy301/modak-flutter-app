import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';

class ColoredSafeArea extends StatelessWidget {
  const ColoredSafeArea({Key? key, this.color = Coloring.gray_50, required this.child}) : super(key: key);

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: SafeArea(
        top: false,
        child: child,
      ),
    );
  }
}
