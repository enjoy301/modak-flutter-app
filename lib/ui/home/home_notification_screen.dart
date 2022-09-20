import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';

class HomeNotificationScreen extends StatelessWidget {
  const HomeNotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
        title: "알림",
        leading: FunctionalIcon.back,
        onClickLeading: () {
          Get.back();
        }
      ),
    );
  }
}
