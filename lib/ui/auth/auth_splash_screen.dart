import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/auth/auth_splash_VM.dart';
import 'package:provider/provider.dart';

class AuthSplashScreen extends StatefulWidget {
  const AuthSplashScreen({Key? key}) : super(key: key);

  @override
  State<AuthSplashScreen> createState() => _AuthSplashScreenState();
}

class _AuthSplashScreenState extends State<AuthSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer6<UserProvider, HomeProvider, TodoProvider, ChatProvider,
            AlbumProvider, AuthSplashVM>(
        builder: (context, userProvider, homeProvider, todoProvider,
            chatProvider, albumProvider, provider, child) {
      return FutureBuilder(future: Future<void>(() async {
        /// 로그인 및 데이터 받아오기 로컬 DB 업데이트
        await provider.init();
        log("0");

        /// 로컬 DB 데이터 메모리에 올림
        await homeProvider.init();
        log("1");
        await userProvider.init();
        log("2");
        await todoProvider.init();
        log("3");
        await chatProvider.init();
        log("4");
        await albumProvider.init();
        log("5");
        /// redirection
        await Future(() => provider.redirection(context));
      }), builder: (context, snapshot) {
        return Scaffold(
          body: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                gradient: Coloring.main,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "lib/assets/images/others/splash_modak_fire.png",
                    width: 160,
                    height: 224,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("MO",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: Font.size_h1 * 1.4,
                            fontWeight: Font.weight_bold,
                          )),
                      Text(
                        "DAK",
                        style: TextStyle(
                          color: Color(0XFF583668),
                          fontSize: Font.size_h1 * 1.4,
                          fontWeight: Font.weight_bold,
                        ),
                      )
                    ],
                  ),
                  Text(
                    "family messenger app",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: Font.size_largeText,
                      fontWeight: Font.weight_regular,
                    ),
                  ),
                ],
              )),
        );
      });
    });
  }
}
