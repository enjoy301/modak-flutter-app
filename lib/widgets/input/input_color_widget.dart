import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/user_colors.dart';

class InputColorWidget extends StatefulWidget {
  const InputColorWidget({Key? key, required this.color, required this.onColorChanged}) : super(key: key);

  final Color color;
  final Function(Color color) onColorChanged;

  @override
  State<InputColorWidget> createState() => _InputColorWidgetState();
}

class _InputColorWidgetState extends State<InputColorWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
            builder: (context) => AlertDialog(
                  title: Text("색을 선택해주세요"),
                  content: SingleChildScrollView(
                    child: BlockPicker(
                      pickerColor: Colors.black,
                      availableColors: UserColors.points,
                      onColorChanged: widget.onColorChanged,
                    ),
                  ),
                ),
            context: context);
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
              child: Icon(
                LightIcons.Filter3,
                color: Coloring.gray_20,
              ),
            ),
            Text(
              "고유색",
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
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(7),
                ),
              ),
            ),
            Icon(
              LightIcons.ArrowRight2,
              color: Coloring.gray_20,
            )
          ],
        ),
      ),
    );
  }
}
