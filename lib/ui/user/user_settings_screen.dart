import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/common/common_policy_screen.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/utils/notification_controller.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({Key? key}) : super(key: key);

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, snapshot) {
        return Scaffold(
          backgroundColor: Coloring.gray_50,
          appBar: headerDefaultWidget(
            title: "설정",
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Get.back();
            },
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 6, left: 4),
                  child: Text(
                    "알림 수신",
                    style: EasyStyle.text(Colors.black, Font.size_mediumText,
                        Font.weight_regular),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              "Todo 완료 알림 수신",
                              style: EasyStyle.text(Colors.black,
                                  Font.size_largeText, Font.weight_regular),
                            ),
                          ),
                          FlutterSwitch(
                            value: userProvider.todoAlarmReceive,
                            onToggle: (bool value) {
                              userProvider.todoAlarmReceive = value;
                              NotificationController(context).setSubscription();
                            },
                            activeColor: Color(0XFF4CD964),
                            inactiveColor: Colors.grey[400]!,
                          ),
                        ],
                      ),
                      Container(
                        height: 1,
                        color: Coloring.gray_50,
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            CommonPolicyScreen(
                              policyType: PolicyType.operating,
                              withCheck: false,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "채팅 알림 수신",
                                style: EasyStyle.text(Colors.black,
                                    Font.size_largeText, Font.weight_regular),
                              ),
                            ),
                            FlutterSwitch(
                              value: userProvider.chatAlarmReceive,
                              onToggle: (bool value) {
                                userProvider.chatAlarmReceive = value;
                                NotificationController(context)
                                    .setSubscription();
                              },
                              activeColor: Color(0XFF4CD964),
                              inactiveColor: Colors.grey[400]!,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 6, left: 4),
                  child: Text(
                    "약관 정보",
                    style: EasyStyle.text(Colors.black, Font.size_mediumText,
                        Font.weight_regular),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(15),
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            CommonPolicyScreen(
                                policyType: PolicyType.private,
                                withCheck: false),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "개인 정보 약관",
                                style: EasyStyle.text(Colors.black,
                                    Font.size_largeText, Font.weight_regular),
                              ),
                            ),
                            Icon(LightIcons.ArrowRight2)
                          ],
                        ),
                      ),
                      Container(
                        height: 1,
                        color: Coloring.gray_50,
                        margin: EdgeInsets.symmetric(vertical: 10),
                      ),
                      GestureDetector(
                        onTap: () {
                          Get.to(
                            CommonPolicyScreen(
                              policyType: PolicyType.operating,
                              withCheck: false,
                            ),
                          );
                        },
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "이용과 운영 정책",
                                style: EasyStyle.text(Colors.black,
                                    Font.size_largeText, Font.weight_regular),
                              ),
                            ),
                            Icon(LightIcons.ArrowRight2)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 6, left: 4),
                  child: Text(
                    "글씨 크기",
                    style: EasyStyle.text(Colors.black, Font.size_mediumText,
                        Font.weight_regular),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    children: [
                      FlutterToggleTab(
                          labels: ["1.0", "1.5", "2.0"],
                          width: 60,
                          height: 40,
                          selectedLabelIndex: (index) {
                            setState(() {
                              userProvider.sizeSettings = index;
                            });
                          },
                          selectedTextStyle:
                              TextStyle(color: Coloring.point_pureorange),
                          unSelectedTextStyle:
                              TextStyle(color: Coloring.gray_10),
                          unSelectedBackgroundColors: [Coloring.todo_orange],
                          selectedBackgroundColors: [Colors.white],
                          selectedIndex: userProvider.sizeSettings),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
