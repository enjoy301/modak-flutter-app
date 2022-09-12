import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/ui/landing_bottomtab_navigator.dart';
import 'package:modak_flutter_app/widgets/button/button_invitation_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';

class CommonInvitationScreen extends StatelessWidget {
  const CommonInvitationScreen({Key? key, this.withSkipButton = false})
      : super(key: key);

  final bool withSkipButton;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
          title: "초대 하기",
          leading: FunctionalIcon.close,
          onClickLeading: () {
            withSkipButton
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LandingBottomNavigator()))
                : Navigator.pop(context);
          }),
      body: Container(
        margin: EdgeInsets.only(top: 150, right: 30, left: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "가족을 초대하세요!",
              style: TextStyle(
                color: Colors.black,
                fontSize: Font.size_largeText,
                fontWeight: Font.weight_semiBold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ButtonInvitationWidget(type: "phone"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: ButtonInvitationWidget(type: "kakao"),
            ),
            withSkipButton
                ? Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 48.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(child: Text("")),
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LandingBottomNavigator()));
                                  },
                                  style: ButtonStyle(
                                      overlayColor: MaterialStateProperty.all(
                                          Colors.transparent)),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 26, vertical: 10),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(
                                            color: Coloring.gray_30, width: 1)),
                                    child: Row(
                                      children: [
                                        Text(
                                          "초대 건너 뛰기",
                                          style: TextStyle(
                                            color: Coloring.gray_10,
                                            fontSize: Font.size_mediumText,
                                            fontWeight: Font.weight_medium,
                                          ),
                                        ),
                                        Icon(
                                          LightIcons.ArrowRight2,
                                          size: 16,
                                          color: Coloring.gray_10,
                                        ),
                                      ],
                                    ),
                                  )),
                              Expanded(child: Text("")),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )
                : Text(""),
          ],
        ),
      ),
    );
  }
}
