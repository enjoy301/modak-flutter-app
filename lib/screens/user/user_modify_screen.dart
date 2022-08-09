import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/common/common_checkbox_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_color_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_date_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_select_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';

class UserModifyScreen extends StatefulWidget {
  const UserModifyScreen({Key? key}) : super(key: key);

  @override
  State<UserModifyScreen> createState() => _UserModifyScreenState();
}

class _UserModifyScreenState extends State<UserModifyScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: headerDefaultWidget(
            title: "수정하기",
            leading: FunctionalIcon.close,
            onClickLeading: () {
              Navigator.pop(context);
            }),
        body: Padding(
          padding: const EdgeInsets.only(
            top: 32,
            right: 30,
            left: 30,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                    child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000),
                  child: Image.asset(
                    "lib/assets/images/family/profile/dad_profile.png",
                    width: 110,
                    height: 110,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.only(top: 48, bottom: 16,),
                  child: Text(
                    "기본 정보",
                    style: TextStyle(
                      color: Coloring.gray_10,
                      fontSize: Font.size_mediumText,
                      fontWeight: Font.weight_semiBold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: InputTextWidget(isSuffix: true, onClickSuffix: () {}),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: InputSelectWidget(
                      title: "가족 역할",
                      contents: "",
                      buttons: [
                        TextButton(onPressed: () {}, child: Text("아빠")),
                        TextButton(onPressed: () {}, child: Text("엄마")),
                        TextButton(onPressed: () {}, child: Text("아들")),
                        TextButton(onPressed: () {}, child: Text("딸")),
                      ],
                      leftIconData: LightIcons.Profile),
                ),
                InputColorWidget(),
                Padding(
                  padding: const EdgeInsets.only(top: 48, bottom: 16,),
                  child: Row(
                    children: [
                      Text(
                        "생일 정보",
                        style: TextStyle(
                          color: Coloring.gray_10,
                          fontSize: Font.size_mediumText,
                          fontWeight: Font.weight_semiBold,
                        ),
                      ),
                      Expanded(child: Text("")),
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: CommonCheckboxWidget(value: true, onChanged: (bool? value) {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text("음력", style: TextStyle(
                          color: Coloring.gray_10,
                          fontSize: Font.size_smallText,
                          fontWeight: Font.weight_regular,
                        )),
                      ),
                    ],
                  ),
                ),
                InputDateWidget(
                    title: "생일",
                    contents: "2022-12-21",
                    currTime: DateTime.now(),
                    onChanged: (DateTime dateTime) {}),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
            padding: EdgeInsets.only(right: 30, bottom: 20, left: 30),
            child: ButtonMainWidget(title: "수정 완료", onPressed: () {})),
      ),
    );
  }
}
