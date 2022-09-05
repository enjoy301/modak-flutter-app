import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:provider/provider.dart';

class InputDateWidget extends StatelessWidget {
  const InputDateWidget(
      {Key? key,
      required this.title,
      required this.contents,
      required this.onChanged,
      required this.currTime})
      : super(key: key);

  final String title;
  final String contents;
  final Function(DateTime dateTime) onChanged;
  final DateTime currTime;

  @override
  Widget build(BuildContext context) {
      return GestureDetector(
        onTap: () {
          DatePicker.showDatePicker(context,
              minTime: DateTime.utc(1950),
              maxTime: DateTime.now(),
              currentTime: currTime,
              onConfirm: onChanged);
        },
        child: Container(
          padding: EdgeInsets.only(top: 15, right: 15, bottom: 11, left: 15),
          decoration: BoxDecoration(
            color: Coloring.gray_50,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Icon(LightIcons.Calendar, color: Coloring.gray_20,),
              ),
              Text(
                title,
                style: TextStyle(
                  color: Coloring.gray_10,
                  fontSize: Font.size_mediumText,
                  fontWeight: Font.weight_regular,
                ),
              ),
              Expanded(
                child: Text(""),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(contents, style: TextStyle(
                  color: Coloring.gray_10,
                  fontSize: Font.size_mediumText,
                  fontWeight: Font.weight_regular,
                ),),
              ),
              Icon(LightIcons.ArrowRight2, color: Coloring.gray_20,)
            ],
          ),
        ),
      );
  }
}