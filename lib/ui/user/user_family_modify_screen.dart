import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/model/user.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/common/checkbox_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_color_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_date_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_select_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';

class UserFamilyModifyScreen extends StatefulWidget {
  const UserFamilyModifyScreen({Key? key, required this.familyMember}) : super(key: key);

  final User familyMember;

  @override
  State<UserFamilyModifyScreen> createState() => _UserFamilyModifyScreenState();
}

class _UserFamilyModifyScreenState extends State<UserFamilyModifyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
        title: "가족 정보 수정",
        leading: FunctionalIcon.back,
        onClickLeading: () {
          Get.back();
        }
      ),
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
                padding: const EdgeInsets.only(
                  top: 48,
                  bottom: 16,
                ),
                child: Text(
                  "기본 정보",
                  style: TextStyle(
                    color: Coloring.gray_10,
                    fontSize: Font.size_mediumText,
                    fontWeight: Font.weight_semiBold,
                  ),
                ),
              ),
              IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: InputTextWidget(textEditingController: TextEditingController(text: widget.familyMember.name)),
                ),
              ),
              IgnorePointer(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 13),
                  child: InputSelectWidget(
                      title: "가족 역할",
                      contents: widget.familyMember.role,
                      leftIconData: LightIcons.Profile),
                ),
              ),
              IgnorePointer(
                child: InputColorWidget(
                  color: widget.familyMember.color.toColor()!,
                  onColorChanged: (Color color) {},
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 48,
                  bottom: 16,
                ),
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
                      child: CheckboxWidget(
                          value: widget.familyMember.isLunar,
                          onChanged: (bool? value) {}),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: Text("음력",
                          style: TextStyle(
                            color: Coloring.gray_10,
                            fontSize: Font.size_smallText,
                            fontWeight: Font.weight_regular,
                          )),
                    ),
                  ],
                ),
              ),
              IgnorePointer(
                child: InputDateWidget(
                    title: "생일",
                    contents: widget.familyMember.birthDay,
                    currTime: DateTime.parse(widget.familyMember.birthDay),
                    onChanged: (DateTime dateTime) {
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
