import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_screen.dart';
import 'package:modak_flutter_app/ui/landing_bottomtab_navigator.dart';
import 'package:modak_flutter_app/services/auth_service.dart';
import 'package:modak_flutter_app/utils/auth_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/modal/modal_check_widget.dart';
import 'package:get/route_manager.dart';

class AuthInvitationScreen extends StatefulWidget {
  const AuthInvitationScreen({Key? key}) : super(key: key);

  @override
  State<AuthInvitationScreen> createState() => _AuthInvitationScreenState();
}

class _AuthInvitationScreenState extends State<AuthInvitationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
          leading: FunctionalIcon.back,
          onClickLeading: () {
            modalCheckwidget(context,
                title: "가족 초대 받기를 그만두시겠습니까?",
                okText: "확인",
                noText: "닫기",
                onOkPressed: () {
                }, onNoPressed: () {
              Navigator.pop(context);
            });
          }),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("MO",
                      style: TextStyle(
                        color: Coloring.gray_10,
                        fontSize: Font.size_h1 * 1.4,
                        fontWeight: Font.weight_bold,
                      )),
                  Text("DAK",
                      style: TextStyle(
                        color: Color(0XFF583668),
                        fontSize: Font.size_h1 * 1.4,
                        fontWeight: Font.weight_bold,
                      )),
                ],
              ),
            ),
            Text(
              "family messenger app",
              style: TextStyle(
                color: Coloring.gray_10,
                fontSize: Font.size_largeText,
                fontWeight: Font.weight_regular,
              ),
            ),
            Expanded(child: Text("")),
            Padding(
              padding: const EdgeInsets.only(bottom: 32),
              child: Text(
                "가족 링크를 통해 들어오셨습니다\n원활한 서비스 이용을 위해 로그인해주세요",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Coloring.gray_10,
                  fontSize: Font.size_mediumText,
                  fontWeight: Font.weight_regular,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(53),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image.asset(
                          "lib/assets/images/auth/apple_icon.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Text(
                        "애플 계정으로 로그인",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: Font.size_largeText,
                          fontWeight: Font.weight_semiBold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: GestureDetector(
                onTap: () async {
                  if (await AuthUtil.kakaoLogin(context)) {
                    if (PrefsUtil.getInt("provider_id") != null &&
                        PrefsUtil.getString("provider") != null) {
                      Map<String, dynamic> response = await socialLogin(context);
                      print(response['result']);
                      if (response['result'] == "FAIL") {
                        if (response['code'] ==
                            "EmptyResultDataAccessException") {
                          PrefsUtil.setBool("is_register_progress", true);
                          Future(() => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                  const AuthRegisterScreen())));
                        }
                      } else {
                        // ignore: use_build_context_synchronously
                        modalCheckwidget(context, title: "이미 가족이 있습니다. 변경하시겠습니까?", onOkPressed: () {
                          /// update familyId
                          Get.offAll(
                              () => LandingBottomNavigator()
                          );
                        }, onNoPressed: () {
                          Navigator.pop(context);
                        });
                      }
                    }
                  }
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                    color: Color(0XFFFEE500),
                    borderRadius: BorderRadius.circular(53),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Image.asset(
                          "lib/assets/images/auth/kakao_icon.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Text(
                        "카카오 계정으로 로그인",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Font.size_largeText,
                          fontWeight: Font.weight_semiBold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
