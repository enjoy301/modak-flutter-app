import 'dart:developer';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/route_manager.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/screens/auth/auth_splash_screen.dart';
import 'package:modak_flutter_app/screens/auth/reigster/auth_invitation_screen.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:provider/provider.dart';

void main() async {
  // main 에서 await 사용시 실행
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  // sharedPreference singleton 객체 생성
  await PrefsUtil.init();
  // dotenv 파일 로드
  await dotenv.load();
  await Firebase.initializeApp();

  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_KEY"));

  // 한글 지원
  // 상태관리 provider 정의
  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => ChatProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => AlbumProvider()),
      ], child: const MyApp())));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const AuthSplashScreen(),
      theme: ThemeData(
        fontFamily: 'Font_Poppins',
        backgroundColor: Colors.white,
      ),
    );
  }

  @override
  void initState() {
    initDynamicLink();
    super.initState();
  }

  void initDynamicLink() async {
      FirebaseDynamicLinks.instance.onLink
          .listen((PendingDynamicLinkData dynamicLink) async {
        final Uri deepLink = dynamicLink.link;
        // String familyId  = deepLink.queryParameters["id"]!;
        print("deepLink: $dynamicLink");
        print(dynamicLink.link.queryParameters['id']);
        Get.offAll(
            () => AuthInvitationScreen()
        );
      }).onError((error) {
        log(error);
      });
  }
}
