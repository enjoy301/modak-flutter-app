import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:provider/provider.dart';

class InputTextWidget extends StatefulWidget {
  const InputTextWidget({
    Key? key,
    required this.textEditingController,
    this.hint = "",
    this.onChanged,
    this.isSuffix = false,
    this.onClickSuffix,
    this.minLines = 1,
    this.maxLines = 1,
    this.maxLength,
    this.isBlocked = false,
    this.isSatisfied = true,
    this.autofocus = false,
    this.initText = "",
  }) : super(key: key);
  final TextEditingController textEditingController;
  final String hint;
  final Function(String text)? onChanged;
  final bool isSuffix;
  final Function()? onClickSuffix;
  final int minLines;
  final int maxLines;
  final int? maxLength;
  final bool isBlocked;
  final bool isSatisfied;
  final bool autofocus;
  final String initText;

  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  @override
  void initState() {
    widget.textEditingController.text = widget.initText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return IgnorePointer(
        ignoring: widget.isBlocked,
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                autofocus: widget.autofocus,
                minLines: widget.minLines,
                maxLines: widget.maxLines,
                controller: widget.textEditingController,
                onChanged: widget.onChanged,
                maxLength: widget.maxLength,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(15),
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      color: Coloring.hintText,
                      fontSize:
                          Font.size_mediumText * userProvider.getFontScale(),
                      fontWeight: Font.weight_regular,
                    ),
                    filled: true,
                    fillColor: Coloring.gray_40,
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: widget.isSatisfied ? 0 : 1.5,
                            color: widget.isSatisfied
                                ? Coloring.gray_50
                                : Colors.red),
                        borderRadius: BorderRadius.circular(16)),
                    focusColor: Coloring.bg_red,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            width: 1.5,
                            color: widget.isSatisfied
                                ? Coloring.gray_30
                                : Colors.red),
                        borderRadius: BorderRadius.circular(16)),
                    suffixIcon: widget.isSuffix
                        ? IconButton(
                            onPressed: () {
                              widget.onClickSuffix!.call();
                              widget.textEditingController.clear();
                            },
                            icon: Icon(
                              Icons.close,
                              color: Coloring.gray_10,
                              size: 20,
                            ))
                        : null),
                cursorColor: Coloring.gray_0,
                style: TextStyle(
                  color: Coloring.gray_10,
                  fontSize: Font.size_mediumText * userProvider.getFontScale(),
                  fontWeight: Font.weight_regular,
                ),
              ),
              if (!widget.isSatisfied)
                Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Text(
                    "세 글자 이상 입력해주세요",
                    style: EasyStyle.errorText(),
                  ),
                )
            ],
          ),
        ),
      );
    });
  }
}
