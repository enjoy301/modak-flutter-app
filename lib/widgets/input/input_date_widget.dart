import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';

class InputDateWidget extends StatelessWidget {
  const InputDateWidget({
    Key? key,
    required this.title,
    required this.contents,
    required this.onChanged,
    required this.currTime,
    this.maxTime,
    this.minTime,
    this.isFilled = true,
    this.isNecessary = false,
    this.tailIconShow = true,
    this.isBlocked = false,
  }) : super(key: key);

  final String title;
  final String contents;
  final Function(DateTime dateTime) onChanged;
  final DateTime currTime;
  final DateTime? maxTime;
  final DateTime? minTime;
  final bool isFilled;
  final bool isNecessary;
  final bool tailIconShow;
  final bool isBlocked;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isBlocked,
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          DatePicker.showDatePicker(context,
              minTime: minTime ?? DateTime.utc(1950),
              maxTime: maxTime ?? DateTime.now(),
              currentTime: currTime,
              onConfirm: onChanged,
              locale: LocaleType.ko);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 15, right: 15, bottom: 11, left: 15),
              decoration: BoxDecoration(
                color: isBlocked ? Coloring.gray_40 : Coloring.gray_50,
                borderRadius: BorderRadius.circular(16),
                border: !isFilled && isNecessary ? Border.all(color: Colors.red) : null,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      LightIcons.Calendar,
                      color: Coloring.gray_20,
                    ),
                  ),
                  Text(
                    title,
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
                      contents,
                      style: TextStyle(
                        color: isBlocked
                            ? Coloring.blockedText
                            : isFilled
                                ? Coloring.filledText
                                : Coloring.notFilledText,
                        fontSize: Font.size_mediumText,
                        fontWeight: Font.weight_regular,
                      ),
                    ),
                  ),
                  if (tailIconShow)
                    Icon(
                      LightIcons.ArrowRight2,
                      color: Coloring.gray_20,
                    )
                ],
              ),
            ),
            if (!isFilled && isNecessary)
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Text(
                  "날짜를 입력해주세요",
                  style: EasyStyle.errorText(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
