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
        print(userProvider.getNewNotificationNumber());
        return WillPopScope(
          onWillPop: () async {
            userProvider.checkNotification();
            return true;
          },
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: headerDefaultWidget(
                title: isArchiveMode ? "아카이브" : "알림",
                leading: FunctionalIcon.back,
                onClickLeading: () {
                  userProvider.checkNotification();
                  Get.back();
                },
                customTrailing: IconButton(
                  onPressed: () {
                    setState(() {
                      isArchiveMode = !isArchiveMode;
                    });
                  },
                  icon: isArchiveMode
                      ? Icon(
                          Icons.notifications,
                          color: Colors.grey[700],
                        )
                      : Icon(
                          Icons.archive,
                          color: Colors.grey[700],
                        ),
                ),
              ),
              body: isArchiveMode
                  ? ListView.builder(
                      itemCount: userProvider.archiveNotifications.length,
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          notification:
                              userProvider.archiveNotifications[index],
                          onDismiss: () {
                            userProvider.removeArchiveNotification(index);
                          },
                          onArchive: () {
                            userProvider.unArchive(index);
                          },
                        );
                      },
                    )
                  : ListView.builder(
                      itemCount: userProvider.notifications.length,
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          notification: userProvider.notifications[index],
                          onDismiss: () {
                            userProvider.removeNotification(index);
                          },
                          onArchive: () {
                            userProvider.archive(index);
                          },
                        );
                      },
                    )),
        );
      },
    );
  }
}
