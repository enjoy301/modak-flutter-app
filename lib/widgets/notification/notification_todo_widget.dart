import 'package:flutter/material.dart';
import 'package:modak_flutter_app/data/dto/notification.dart';

class NotificationTodoWidget extends StatelessWidget {
  const NotificationTodoWidget({Key? key, required this.notification}) : super(key: key);

  final Noti notification;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Text(notification.title),
          Text(notification.des),
        ],
      ),
    );
  }
}
