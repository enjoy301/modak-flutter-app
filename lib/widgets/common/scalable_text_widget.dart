import 'package:flutter/material.dart';

class ScalableTextWidget extends StatelessWidget {
  const ScalableTextWidget(this.text, {Key? key, this.style = const TextStyle()}) : super(key: key);

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: style,);
  }
}
