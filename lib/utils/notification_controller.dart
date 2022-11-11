import 'dart:io';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/dto/notification.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:provider/provider.dart';

class NotificationController extends GetxController {
  NotificationController(this.context);
  BuildContext context;
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  bool isFlutterLocalNotificationsInitialized = false;
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static late String _familyId;
  static late String _memberId;

  @override
  void onInit() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
    _familyId = (await RemoteDataSource.storage.read(key: Strings.familyId))!;
    _memberId = (await RemoteDataSource.storage.read(key: Strings.memberId))!;
    _getToken();
    setSubscription();

    super.onInit();
  }

  void _getToken() async {
    print("??");
    final authStatus = await messaging.requestPermission();
    print(authStatus.authorizationStatus);
    print("fcm token ${await messaging.getToken()}");
  }

  Future<void> setupFlutterNotifications() async {
    if (isFlutterLocalNotificationsInitialized) {
      return;
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    isFlutterLocalNotificationsInitialized = true;
  }

  void showFlutterNotification(RemoteMessage message) {
    Map<String, dynamic> data = message.data;
    if (Platform.isAndroid) {
      flutterLocalNotificationsPlugin.show(
        1,
        data['title'],
        data['body'],
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/launcher_icon',
          ),
        ),
      );
    }
  }

  Future<void> _firebaseMessagingForegroundHandler(
      RemoteMessage message) async {
    /// setting and verifying
    await setupFlutterNotifications();

    /// load and display
    _addNotification(message);
    showFlutterNotification(message);
  }

  Future<void> _firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // await Firebase.initializeApp();
    print("data values:${message.data.values}");

    /// setting and verifying
    await setupFlutterNotifications();

    /// load and display
    _addNotification(message);
    showFlutterNotification(message);

    print('Handling a background message ${message.messageId}');
  }

  subscribe(String topic) {
    messaging.subscribeToTopic(topic);
  }

  unsubscribe(String topic) {
    messaging.unsubscribeFromTopic(topic);
  }

  _addNotification(RemoteMessage message) async {
    await Future(
      () => context.read<UserProvider>().addNotification(
            Noti(
                notiType: Strings.notiTodo,
                title: message.notification?.title ?? "제목",
                des: message.notification?.body ?? "설명",
                isRead: false,
                metaData: {}),
          ),
    );
  }

  static void sendNotification(String title, String body, String type,
      {List<String> memberIds = const [], String develop = ""}) {
    Dio(BaseOptions(
      headers: {
        "Content-Type": "application/json",
        "Authorization": "key=${dotenv.get("FCM_KEY")}"
      },
    )).post(
      "https://fcm.googleapis.com/fcm/send",
      data: {
        "to": "/topics/FAM$_familyId$type",
        "notification": {
          "title": title,
          "body": body,
        },
        "data": {
          "title": title,
          "body": body,
          'develop': develop,
          "type": type,
          "memberIds": memberIds,
        }
      },
    );
  }

  void setSubscription() {
    bool todoAlarmReceive = context.read<UserProvider>().todoAlarmReceive;
    bool chatAlarmReceive = context.read<UserProvider>().chatAlarmReceive;
    subscribe("FAM$_familyId");
    todoAlarmReceive
        ? subscribe("FAM${_familyId}todo")
        : unsubscribe("FAM${_familyId}todo");
    chatAlarmReceive
        ? subscribe("FAM${_familyId}chat")
        : unsubscribe("FAM${_familyId}chat");
  }

  void unSubscribeAll() {
    unsubscribe("FAM$_familyId");
    unsubscribe("FAM${_familyId}todo");
    unsubscribe("FAM${_familyId}chat");
  }

  // bool _checkNotification(RemoteMessage message) {
  //   bool memberCheck = false;
  //   bool typeCheck = false;
  //   bool todoAlarmReceive = context.read<UserProvider>().todoAlarmReceive;
  //   bool chatAlarmReceive = context.read<UserProvider>().chatAlarmReceive;
  //
  //   List<String> memberIds =
  //       json.decode(message.data['memberIds']).cast<String>().toList();
  //
  //   String type = message.data['type'];
  //
  //   if (message.data['develop'] == 'force') {
  //     return true;
  //   }
  //   if (memberIds.isEmpty || memberIds.contains(_memberId)) {
  //     memberCheck = true;
  //   }
  //   if (type == 'all' ||
  //       (type == 'todo' && todoAlarmReceive) ||
  //       (type == 'chat' && chatAlarmReceive)) {
  //     typeCheck = true;
  //   }
  //
  //   print(memberCheck);
  //   print(typeCheck);
  //   return memberCheck && typeCheck;
  // }
}
