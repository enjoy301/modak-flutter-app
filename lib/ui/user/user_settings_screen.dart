import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/common/common_policy_screen.dart';
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
    return Consumer<UserProvider>(builder: (context, userProvider, snapshot) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: headerDefaultWidget(
            title: "설정",
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Get.back();
            }),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 40, bottom: 10),
              child: FlutterToggleTab(
                  labels: ["1.0", "1.5", "2.0"],
                  width: 60,
                  selectedLabelIndex: (index) {
                    setState(() {
                      userProvider.sizeSettings = index;
                    });
                  },
                  selectedTextStyle: TextStyle(),
                  unSelectedTextStyle: TextStyle(color: Colors.white),
                  unSelectedBackgroundColors: [Colors.grey[600]!],
                  selectedBackgroundColors: [Colors.white],
                  selectedIndex: userProvider.sizeSettings),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Coloring.gray_40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 30),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Todo 완료 알림 수신"),
                    FlutterSwitch(
                      value: userProvider.todoAlarmReceive,
                      onToggle: (bool value) {
                        userProvider.todoAlarmReceive = value;
                        NotificationController(context).setSubscription();
                      },
                      activeColor: Colors.blueAccent,
                      inactiveColor: Colors.grey[400]!,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                padding:
                    EdgeInsets.only(top: 10, right: 20, bottom: 10, left: 30),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("채팅 알림 수신"),
                    FlutterSwitch(
                      value: userProvider.chatAlarmReceive,
                      onToggle: (bool value) {
                        userProvider.chatAlarmReceive = value;
                        NotificationController(context).setSubscription();
                      },
                      activeColor: Colors.blueAccent,
                      inactiveColor: Colors.grey[400]!,
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Coloring.gray_40,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  Get.to(CommonPolicyScreen(
                      policyType: PolicyType.private, withCheck: false));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "개인 정보 약관",
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: Font.size_subTitle,
                      fontWeight: Font.weight_bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: GestureDetector(
                onTap: () {
                  Get.to(CommonPolicyScreen(
                    policyType: PolicyType.operating,
                    withCheck: false,
                  ));
                },
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    color: Colors.grey[500],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    "이용과 운영 정책",
                    style: TextStyle(
                      color: Colors.grey[100],
                      fontSize: Font.size_subTitle,
                      fontWeight: Font.weight_bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
