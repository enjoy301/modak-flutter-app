import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/notification/notification_widget.dart';
import 'package:provider/provider.dart';

class HomeNotificationScreen extends StatefulWidget {
  const HomeNotificationScreen({Key? key}) : super(key: key);

  @override
  State<HomeNotificationScreen> createState() => _HomeNotificationScreenState();
}

class _HomeNotificationScreenState extends State<HomeNotificationScreen> {
  bool isArchiveMode = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, child) {
        return WillPopScope(
          onWillPop: () async {
            userProvider.checkNotification();
            return true;
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: headerDefaultWidget(
              bgColor: Colors.white,
              title: "알림",
              leading: FunctionalIcon.back,
              onClickLeading: () {
                userProvider.checkNotification();
                Get.back();
              },
            ),
            body: ListView.builder(
              itemCount: userProvider.notifications.length,
              itemBuilder: (context, index) {
                return NotificationWidget(
                  notification: userProvider.notifications[index],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
