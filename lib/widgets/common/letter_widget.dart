import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/data/model/letter.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class LetterWidget extends StatefulWidget {
  const LetterWidget(
      {Key? key, required this.letter, this.onTap, this.onSelected = false})
      : super(key: key);

  final Letter letter;
  final Function()? onTap;
  final onSelected;

  @override
  State<LetterWidget> createState() => _LetterWidgetState();
}

class _LetterWidgetState extends State<LetterWidget> {
  final Map<EnvelopeType, dynamic> letterEnvelop = {
    EnvelopeType.red: {
      "background": Colors.redAccent,
    },
    EnvelopeType.brown: {
      "background": Colors.brown,
    },
    EnvelopeType.cyan: {
      "background": Colors.lightBlue,
    },
    EnvelopeType.green: {
      "background": Colors.lightGreen,
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
            borderRadius: BorderRadius.circular(10),
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: letterEnvelop[widget.letter.envelope]['background']
                      [100],
                  borderRadius: BorderRadius.circular(10),
                  border: widget.onSelected
                      ? Border.all(color: Colors.white70, width: 3)
                      : null),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(
                          "To ${userProvider.findUserById(widget.letter.toMemberId)?.name ?? ""}"),
                      Expanded(child: SizedBox()),
                      Text(widget.letter.date)
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: 130,
                    child: Text(
                      '${widget.letter.content}\n\n\n',
                      maxLines: 3,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Text(
                          "from ${userProvider.findUserById(widget.letter.fromMemberId)!.name}")
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
