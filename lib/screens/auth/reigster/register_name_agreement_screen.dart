import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:modak_flutter_app/screens/common/common_policy_screen.dart';
import 'package:modak_flutter_app/widgets/input/input_date_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';
import 'package:provider/provider.dart';

class RegisterNameAgreementScreen extends StatefulWidget {
  const RegisterNameAgreementScreen({Key? key}) : super(key: key);

  @override
  State<RegisterNameAgreementScreen> createState() =>
      _RegisterNameAgreementScreenState();
}

class _RegisterNameAgreementScreenState
    extends State<RegisterNameAgreementScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
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
                initialValue: provider.name,
                hint: "이름을 입력해주세요",
                onChanged: (String name) {
                  provider.setName(name);
                },
                isSuffix: provider.name.isNotEmpty,
                onClickSuffix: () {
                  provider.setName("");
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
                  SizedBox(
                      width: 24,
                      height: 24,
                      child:
                          Checkbox(value: provider.isLunar, onChanged: (bool? value) {
                            provider.toggleIsLunar();
                          })),
                  Padding(
                    padding: const EdgeInsets.only(right: 24.0, left: 9),
                    child: Text("음력", style: TextStyle(
                      color: Coloring.gray_10,
                      fontSize: Font.size_smallText,
                      fontWeight: Font.weight_regular,
                    ),),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: InputDateWidget(
                  title: "생일",
                  contents: provider.birthDay != null
                      ? "${provider.birthDay!.year}년 ${provider.birthDay!.month}월 ${provider.birthDay!.day}일"
                      : "날짜를 입력해주세요",
                  onChanged: (DateTime dateTime) {
                    provider.setBirthDay(dateTime);
                  },
                  currTime: provider.birthDay ?? DateTime.now()),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    margin: EdgeInsets.only(right: 10),
                    child: Checkbox(
                        value: provider.isPrivateInformationAgreed,
                        onChanged: (bool? value) {
                          provider.toggleIsPrivateInformationAgreed();
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
            Container(
              margin: EdgeInsets.only(left: 34),
              child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommonPolicyScreen(
                                  policyType: PolicyType.private,
                                )));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Coloring.gray_50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: Text(
                          "상세 보기 >",
                          style: TextStyle(
                              color: Coloring.gray_10,
                              fontSize: Font.size_smallText,
                              fontWeight: Font.weight_regular),
                        ),
                      ))),
            ),
            SizedBox(
              height: 18,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: EdgeInsets.only(right: 10),
                  child: Checkbox(
                      value: provider.isOperatingPolicyAgreed,
                      onChanged: (bool? value) {
                        provider.toggleIsOperatingPolicyAgreed();
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
            Container(
              margin: EdgeInsets.only(left: 34),
              child: TextButton(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CommonPolicyScreen(
                                  policyType: PolicyType.operating,
                                )));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                        color: Coloring.gray_50,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 2),
                        child: Text(
                          "상세 보기 >",
                          style: TextStyle(
                              color: Coloring.gray_10,
                              fontSize: Font.size_smallText,
                              fontWeight: Font.weight_regular),
                        ),
                      ))),
            ),
          ],
        ),
      );
    });
  }
}
