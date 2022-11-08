import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_VM.dart';
import 'package:modak_flutter_app/ui/common/common_policy_screen.dart';
import 'package:modak_flutter_app/widgets/common/checkbox_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_date_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';

class RegisterNameAgreementScreen extends StatefulWidget {
  const RegisterNameAgreementScreen({Key? key, required this.provider, required this.controller}) : super(key: key);

  final AuthRegisterVM provider;
  final TextEditingController controller;

  @override
  State<RegisterNameAgreementScreen> createState() => _RegisterNameAgreementScreenState();
}

class _RegisterNameAgreementScreenState extends State<RegisterNameAgreementScreen> {
  @override
  void initState() {
    widget.controller.text = widget.provider.name;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(right: 30.0, bottom: 150.0, left: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "이름",
            style: TextStyle(
              color: Coloring.gray_10,
              fontSize: Font.size_mediumText,
              fontWeight: Font.weight_semiBold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: InputTextWidget(
              textEditingController: widget.controller,
              hint: "이름을 입력해주세요",
              onChanged: (String name) async {
                widget.provider.name = name;
              },
              isSuffix: widget.provider.name.isNotEmpty,
              onClickSuffix: () {
                widget.provider.name = "";
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: [
                Text(
                  "생일",
                  style: TextStyle(
                    color: Coloring.gray_10,
                    fontSize: Font.size_mediumText,
                    fontWeight: Font.weight_semiBold,
                  ),
                ),
                Expanded(child: Text("")),
                CheckboxWidget(
                    value: widget.provider.isLunar,
                    onChanged: (bool? value) {
                      widget.provider.isLunar = value!;
                    }),
                GestureDetector(
                  onTap: () {
                    bool before = widget.provider.isLunar;
                    widget.provider.isLunar = !before;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 24.0, left: 9),
                    child: Text(
                      "음력",
                      style: TextStyle(
                        color: Coloring.gray_10,
                        fontSize: Font.size_smallText,
                        fontWeight: Font.weight_regular,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: InputDateWidget(
                title: "생일",
                contents: widget.provider.birthDay != null
                    ? "${widget.provider.birthDay!.year}년 ${widget.provider.birthDay!.month}월 ${widget.provider.birthDay!.day}일"
                    : "날짜를 입력해주세요",
                onChanged: (DateTime dateTime) {
                  widget.provider.birthDay = dateTime;
                },
                currTime: widget.provider.birthDay ?? DateTime.now()),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 24.0),
            child: GestureDetector(
              onTap: () {
                bool before = widget.provider.isPrivateInformationAgreed;
                widget.provider.isPrivateInformationAgreed = !before;
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    margin: EdgeInsets.only(right: 10),
                    child: CheckboxWidget(
                        value: widget.provider.isPrivateInformationAgreed,
                        onChanged: (bool? value) {
                          widget.provider.isPrivateInformationAgreed = value!;
                        }),
                  ),
                  Text(
                    "개인정보 수집, 이용에 동의합니다.",
                    style: TextStyle(
                      color: Coloring.gray_10,
                      fontSize: Font.size_smallText,
                      fontWeight: Font.weight_regular,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 34),
            child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () async {
                  bool result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommonPolicyScreen(
                                isChecked: widget.provider.isPrivateInformationAgreed,
                                policyType: PolicyType.private,
                              )));
                  widget.provider.isPrivateInformationAgreed = result;
                  print(result);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Coloring.gray_50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text(
                        "상세 보기 >",
                        style: TextStyle(
                            color: Coloring.gray_10, fontSize: Font.size_smallText, fontWeight: Font.weight_regular),
                      ),
                    ))),
          ),
          SizedBox(
            height: 18,
          ),
          GestureDetector(
            onTap: () {
              bool before = widget.provider.isOperatingPolicyAgreed;
              widget.provider.isOperatingPolicyAgreed = !before;
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  margin: EdgeInsets.only(right: 10),
                  child: CheckboxWidget(
                      value: widget.provider.isOperatingPolicyAgreed,
                      onChanged: (bool? value) {
                        widget.provider.isOperatingPolicyAgreed = value!;
                      }),
                ),
                Text(
                  "Modak 운영 정책에 동의합니다.",
                  style: TextStyle(
                    color: Coloring.gray_10,
                    fontSize: Font.size_smallText,
                    fontWeight: Font.weight_regular,
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 34),
            child: TextButton(
                style: TextButton.styleFrom(
                  padding: EdgeInsets.all(0),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () async {
                  bool result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CommonPolicyScreen(
                                isChecked: widget.provider.isOperatingPolicyAgreed,
                                policyType: PolicyType.operating,
                              )));
                  widget.provider.isOperatingPolicyAgreed = result;
                  print(result);
                },
                child: Container(
                    decoration: BoxDecoration(
                      color: Coloring.gray_50,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                      child: Text(
                        "상세 보기 >",
                        style: TextStyle(
                            color: Coloring.gray_10, fontSize: Font.size_smallText, fontWeight: Font.weight_regular),
                      ),
                    ))),
          ),
        ],
      ),
    );
  }
}
