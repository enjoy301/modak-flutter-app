import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/route_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/auth/auth_landing_VM.dart';
import 'package:modak_flutter_app/ui/auth/auth_landing_screen.dart';
import 'package:modak_flutter_app/ui/auth/auth_splash_VM.dart';
import 'package:modak_flutter_app/ui/auth/auth_splash_screen.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_VM.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_screen.dart';
import 'package:modak_flutter_app/ui/chat/letter/chat_letter_VM.dart';
import 'package:modak_flutter_app/ui/chat/letter/landing/chat_letter_landing_screen.dart';
import 'package:modak_flutter_app/ui/chat/letter/write/letter_write_content_screen.dart';
import 'package:modak_flutter_app/ui/chat/letter/write/letter_write_envelop_screen.dart';
import 'package:modak_flutter_app/ui/chat/roulette/chat_roulette_landing_screen.dart';
import 'package:modak_flutter_app/ui/home/home_notification_screen.dart';
import 'package:modak_flutter_app/ui/landing_bottomtab_navigator.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_VM.dart';
import 'package:modak_flutter_app/ui/todo/landing/todo_landing_screen.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_write_VM.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_write_screen.dart';
import 'package:modak_flutter_app/ui/user/invitation/user_invitation_input_VM.dart';
import 'package:modak_flutter_app/ui/user/invitation/user_invitation_input_screen.dart';
import 'package:modak_flutter_app/ui/user/invitation/user_invitation_landing_screen.dart';
import 'package:modak_flutter_app/ui/user/user_landing_screen.dart';
import 'package:modak_flutter_app/ui/user/user_modify_VM.dart';
import 'package:modak_flutter_app/ui/user/user_modify_screen.dart';
import 'package:modak_flutter_app/ui/user/user_settings_screen.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:provider/provider.dart';

void main() async {
  // main 에서 await 사용시 실행
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  // Hive 시작
  await Hive.initFlutter();

  // Hive 객체 등록
  Hive.registerAdapter<User>(UserAdapter());

  await Hive.openBox('auth');
  await Hive.openBox('user');
  await Hive.openBox('todo');
  await Hive.openBox('chat');
  await Hive.openBox('album');

  // sharedPreference singleton 객체 생성
  await PrefsUtil.init();

  // dotenv 파일 로드
  await dotenv.load();
  await Firebase.initializeApp();

  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_KEY"));

  // 한글 지원
  // 상태관리 provider 정의
  initializeDateFormatting().then((_) => runApp(MultiProvider(providers: [
        /// share provider
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => TodoProvider()),
        ChangeNotifierProvider(create: (_) => AlbumProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),

        /// main page provider
        ChangeNotifierProvider(create: (_) => TodoLandingVM()),
        ChangeNotifierProvider(create: (_) => ChatLetterVM()),
      ], child: Phoenix(child: const MyApp()))));
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
      theme: ThemeData(
        fontFamily: 'Font_Poppins',
        backgroundColor: Colors.white,
      ),
      initialRoute: "/auth/splash",
      routes: {
        "/main": (context) => LandingBottomNavigator(),
        "/home/notification": (context) => HomeNotificationScreen(),
        "/auth/splash": (context) => ChangeNotifierProvider(
              create: (_) => AuthSplashVM(),
              child: AuthSplashScreen(),
            ),
        "/auth/landing": (context) => ChangeNotifierProvider(
              create: (_) => AuthLandingVM(),
              child: AuthLandingScreen(),
            ),
        "/auth/register": (context) => ChangeNotifierProvider(
              create: (_) => AuthRegisterVM(),
              child: AuthRegisterScreen(),
            ),
        "/todo/landing": (context) => ChangeNotifierProvider(
              create: (_) => TodoLandingVM(),
              child: TodoLandingScreen(),
            ),
        "/todo/write": (context) => ChangeNotifierProvider(
              create: (_) => TodoWriteVM(),
              child: TodoWriteScreen(),
            ),
        "/chat/letter/landing": (context) => ChatLetterLandingScreen(),
        "/letter/write/content": (context) => LetterWriteContentScreen(),
        "/letter/write/envelop": (context) => LetterWriteEnvelopScreen(),
        "/chat/roulette/landing": (context) => ChatRouletteLandingScreen(),
        "user/landing": (context) => UserLandingScreen(),
        "/user/modify": (context) => ChangeNotifierProvider(
              create: (_) => UserModifyVM(),
              child: UserModifyScreen(),
            ),
        "/user/settings": (context) => UserSettingsScreen(),
        "/user/invitation/landing": (context) => UserInvitationLandingScreen(),
        "/user/invitation/input": (context) => ChangeNotifierProvider(
            create: (_) => UserInvitationInputVM(),
            child: UserInvitationInputScreen()),
      },
    );
  }
}
