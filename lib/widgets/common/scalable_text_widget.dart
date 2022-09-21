import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ScalableTextWidget extends StatefulWidget {
  const ScalableTextWidget(this.text,
      {Key? key, this.style = const TextStyle(), this.textAlign = TextAlign.start})
      : super(key: key);

  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  @override
  State<ScalableTextWidget> createState() => _ScalableTextWidgetState();
}

class _ScalableTextWidgetState extends State<ScalableTextWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Text(widget.text,
        style: TextStyle(
          color: widget.style.color,
          fontSize:
              widget.style.fontSize! * context.watch<UserProvider>().fontScale,
          fontWeight: widget.style.fontWeight,
          decoration: widget.style.decoration,
          decorationStyle: widget.style.decorationStyle,
          decorationThickness: 3,
          decorationColor: widget.style.decorationColor,
        ), textAlign: widget.textAlign,);
  }
}
