import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/data/dto/letter.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:provider/provider.dart';

class LetterWidget extends StatefulWidget {
  const LetterWidget(
      {Key? key, required this.letter, this.onTap, this.onSelected = false})
      : super(key: key);

  final Letter letter;
  final Function()? onTap;
  final bool onSelected;

  @override
  State<LetterWidget> createState() => _LetterWidgetState();
}

class _LetterWidgetState extends State<LetterWidget> {
  final Map<EnvelopeType, dynamic> letterEnvelop = {
    EnvelopeType.red: {
      "background": Colors.white,
    },
    EnvelopeType.brown: {
      "background": Coloring.bg_red,
    },
    EnvelopeType.cyan: {
      "background": Coloring.bg_orange,
    },
    EnvelopeType.green: {
      "background": Coloring.bg_purple,
    }
  };

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: GestureDetector(
          onTap: widget.onTap,
          child: Material(
            elevation: widget.onSelected ? 10 : 0,
            borderRadius: BorderRadius.circular(15),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: letterEnvelop[widget.letter.envelope]['background'],
                  borderRadius: BorderRadius.circular(15),
                  border: widget.onSelected
                      ? Border.all(color: Colors.white70, width: 3)
                      : null,
                  boxShadow: [
                    Shadowing.grey,
                  ]),
              child: Column(
                children: [
                  Row(
                    children: [
                      ScalableTextWidget(
                        "To ${userProvider.findUserById(widget.letter.toMemberId)?.name ?? ""}",
                        style: EasyStyle.text(Colors.black,
                            Font.size_mediumText, Font.weight_medium),
                      ),
                      Expanded(child: SizedBox()),
                      Text(
                        Date.getFormattedDate(
                            format: "yyyy.MM.dd",
                            dateTime: DateTime.parse(widget.letter.date)),
                        style: EasyStyle.text(Colors.black,
                            Font.size_mediumText, Font.weight_regular),
                      )
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: ScalableTextWidget(
                      widget.letter.content,
                      maxLines: 3,
                      textAlign: TextAlign.left,
                      style: EasyStyle.text(Colors.black, Font.size_largeText,
                          Font.weight_regular),
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Text(
                        "from ${userProvider.findUserById(widget.letter.fromMemberId)!.name}",
                        style: EasyStyle.text(Colors.black,
                            Font.size_mediumText, Font.weight_medium),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
