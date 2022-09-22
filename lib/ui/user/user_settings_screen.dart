import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
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
          appBar: headerDefaultWidget(
              title: "설정",
              leading: FunctionalIcon.back,
              onClickLeading: () {
                Get.back();
              }),
          body: Column(
            children: [
              FlutterToggleTab(
                  labels: ["1.0", "1.5", "2.0"],
                  selectedLabelIndex: (index) {
                    setState(() {
                      userProvider.sizeSettings = index;
                    });
                  },
                  selectedTextStyle: TextStyle(),
                  unSelectedTextStyle: TextStyle(),
                  unSelectedBackgroundColors: [Colors.black],
                  selectedBackgroundColors: [Colors.white],
                  selectedIndex: userProvider.sizeSettings)
            ],
          ),
        );
      }
    );
  }
}
