import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';

class ButtonInvitationWidget extends StatelessWidget {
  const ButtonInvitationWidget({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  Widget build(BuildContext context) {
    Map<String, Map<String, String>> data = {
      "phone": {
        "title": "전화번호로 초대하기",
        "image": "lib/assets/images/others/phone_invitation.png",
      },
      "kakao": {
        "title": "카카오톡으로 초대하기",
        "image": "lib/assets/images/others/kakao_invitation.png",
      },
    };
    return ElevatedButton(
      onPressed: () {},
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ))),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0, vertical: 15, ),
        child: Row(
          children: [
            Image.asset(
              data[type]!["image"]!,
              width: 50,
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(
                data[type]!["title"]!,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Font.size_mediumText,
                  fontWeight: Font.weight_medium,
                ),
              ),
            ),
            Expanded(child: Text("")),
            IconGradientWidget(
                LightIcons.ArrowRightCircle, 30, Coloring.sub_purple)
          ],
        ),
      ),
    );
  }
}
