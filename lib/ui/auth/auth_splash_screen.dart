import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/auth/auth_splash_VM.dart';
import 'package:modak_flutter_app/utils/provider_controller.dart';
import 'package:provider/provider.dart';

class AuthSplashScreen extends StatefulWidget {
  const AuthSplashScreen({Key? key}) : super(key: key);

  @override
  State<AuthSplashScreen> createState() => _AuthSplashScreenState();
}

class _AuthSplashScreenState extends State<AuthSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer6<UserProvider, HomeProvider, TodoProvider, ChatProvider, AlbumProvider, AuthSplashVM>(
      builder: (context, userProvider, homeProvider, todoProvider, chatProvider, albumProvider, provider, child) {
        return FutureBuilder(
          future: Future<void>(
            () async {
              /// 로그인 및 데이터 받아오기 로컬 DB 업데이트
              /// redirection path: 첫 화면, 회원가입, 홈 페이지 중 하나로 이동
              String redirectionPath = await provider.init();

              if (redirectionPath == "/main") {
                await Future(() async => await ProviderController.startProviders(context));
              }

              /// redirection
              await Future(() => provider.redirection(context));
            },
          ),
          builder: (context, snapshot) {
            return Scaffold(
              body: Container(
                width: double.infinity,
                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/assets/images/others/splash_image.png",
                      width: 160,
                      height: 224,
                    ),
                    Text(
                      "MODAK",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Font.size_h1 * 1.4,
                        fontWeight: Font.weight_bold,
                      ),
                    ),
                    Text(
                      "모닥으로 소통하는 우리 가족",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Font.size_largeText,
                        fontWeight: Font.weight_regular,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
