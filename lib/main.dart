import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/screens/auth/auth_splash_screen.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:provider/provider.dart';

void main() async {
  // main 에서 await 사용시 실행
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  // sharedPreference singleton 객체 생성
  PrefsUtil.init();
  // dotenv 파일 로드
  await dotenv.load();

  KakaoSdk.init(nativeAppKey: dotenv.get("KAKAO_KEY"));
  // 한글 지원
  // 상태관리 provider 정의
  initializeDateFormatting().then((_) =>runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => ChatProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => TodoProvider()),
    ChangeNotifierProvider(create: (_) => AuthProvider()),
    ChangeNotifierProvider(create: (_) => AlbumProvider()),
  ], child: const MyApp())));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: const AuthSplashScreen(),
      theme: ThemeData(
        fontFamily: 'Font_Poppins',
        backgroundColor: Colors.white,
      ),
    );
  }
}
