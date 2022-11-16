import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/widgets/modal/list_modal_widget.dart';

class InputSelectWidget extends StatefulWidget {
  const InputSelectWidget({
    Key? key,
    required this.title,
    required this.contents,
    required this.isFilled,
    this.buttons = const {},
    this.leftIconData,
    this.onTap,
    this.tailIconShow = true,
    this.isBlocked = false,
  }) : super(key: key);

  final String title;
  final String contents;
  final bool isFilled;
  final Map<String, Function()> buttons;
  final IconData? leftIconData;
  final Function()? onTap;
  final bool tailIconShow;
  final bool isBlocked;

  @override
  State<InputSelectWidget> createState() => _InputSelectWidgetState();
}

class _InputSelectWidgetState extends State<InputSelectWidget> {
  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: widget.isBlocked,
      child: GestureDetector(
        onTap: widget.onTap ??
            () {
              FocusScope.of(context).requestFocus(FocusNode());
              listModalWidget(
                context,
                widget.buttons,
              );
            },
        child: Container(
          padding: EdgeInsets.only(top: 15, right: 15, bottom: 11, left: 15),
          decoration: BoxDecoration(
            color: widget.isBlocked ? Coloring.gray_40 : Coloring.gray_50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: widget.leftIconData == null
                    ? Text("")
                    : Icon(
                        widget.leftIconData,
                        color: Coloring.gray_20,
                      ),
              ),
              Text(
                widget.title,
                style: TextStyle(
                  color: Coloring.titleText,
                  fontSize: Font.size_mediumText,
                  fontWeight: Font.weight_regular,
                ),
              ),
              Expanded(
                child: Text(""),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  widget.contents,
                  style: TextStyle(
                    color: widget.isBlocked
                        ? Coloring.blockedText
                        : widget.isFilled
                            ? Coloring.filledText
                            : Coloring.notFilledText,
                    fontSize: Font.size_mediumText,
                    fontWeight: Font.weight_regular,
                  ),
                ),
              ),
              if (widget.tailIconShow)
                Icon(
                  LightIcons.ArrowRight2,
                  color: Coloring.gray_20,
                )
            ],
          ),
        ),
      ),
    );
  }
}
