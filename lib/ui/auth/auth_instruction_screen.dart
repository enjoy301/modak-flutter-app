import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';

class AuthInstructionScreen extends StatelessWidget {
  const AuthInstructionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
          title: "초대 받으셨나요?",
          leading: FunctionalIcon.back,
          onClickLeading: () {
            Navigator.pop(context);
          }),
      body: Padding(
        padding: const EdgeInsets.only(top: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset("lib/assets/images/others/invited_description.png"),
            Padding(
              padding: const EdgeInsets.only(top: 26.0),
              child: Text(
                "초대자가 보낸 링크를 SMS 혹은 카카오톡을 통해 확인하세요.",
                style: TextStyle(
                  color: Coloring.gray_10,
                  fontSize: Font.size_smallText,
                  fontWeight: Font.weight_regular,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
