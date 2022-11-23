import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class ScalableTextWidget extends StatefulWidget {
  const ScalableTextWidget(this.text,
      {Key? key,
      this.maxLines = 100000,
      this.style = const TextStyle(),
      this.textAlign = TextAlign.start,
      this.overflow})
      : super(key: key);

  final String text;
  final int maxLines;
  final TextStyle style;
  final TextAlign textAlign;
  final TextOverflow? overflow;

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
    return Text(
      widget.text,
      maxLines: widget.maxLines,
      style: TextStyle(
        height: 1.5,
        color: widget.style.color,
        fontSize: widget.style.fontSize! *
            context.watch<UserProvider>().getFontScale(),
        fontWeight: widget.style.fontWeight,
        decoration: widget.style.decoration,
        decorationStyle: widget.style.decorationStyle,
        decorationThickness: 3,
        decorationColor: widget.style.decorationColor,
        overflow: widget.style.overflow,
      ),
      textAlign: widget.textAlign,
    );
  }
}
