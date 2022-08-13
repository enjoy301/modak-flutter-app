import 'dart:io';

import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_talk.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/screens/auth/auth_landing_screen.dart';
import 'package:modak_flutter_app/screens/auth/reigster/auth_invitation_screen.dart';
import 'package:modak_flutter_app/screens/auth/reigster/auth_register_screen.dart';
import 'package:modak_flutter_app/screens/landing_bottomtab_navigator.dart';
import 'package:modak_flutter_app/services/auth_service.dart';
import 'package:modak_flutter_app/utils/file_system_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:provider/provider.dart';

class AuthSplashScreen extends StatefulWidget {
  const AuthSplashScreen({Key? key}) : super(key: key);

  @override
  State<AuthSplashScreen> createState() => _AuthSplashScreenState();
}

class _AuthSplashScreenState extends State<AuthSplashScreen> {
  @override
  Widget build(BuildContext context) {
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
  }

  @override
  // ignore: must_call_super
  void initState() {
    navigateToNextPage();
  }

  navigateToNextPage() async {
    /// 유저가 생성되어 있을 때 처리
    if (PrefsUtil.getString("refresh_token") != null &&
        PrefsUtil.getString("access_token") != null) {
      Map<String, dynamic> response = await tokenLogin();
      if (response['result'] == 'SUCCESS') {
        Directory? directory = await FileSystemUtil.getMediaDirectory();
        if (directory != null) {
          Directory messengerDirectory =
              Directory("${directory.path}/${UserProvider.family_id}");
          Directory todoDirectory =
              Directory("${directory.path}/${UserProvider.family_id}");

          if (!await messengerDirectory.exists()) {
            await messengerDirectory.create(recursive: true);
          }

          if (!await todoDirectory.exists()) {
            await todoDirectory.create(recursive: true);
          }

          List<FileSystemEntity> messengerFiles =
              messengerDirectory.listSync(recursive: true);
          List<FileSystemEntity> todoFiles =
              todoDirectory.listSync(recursive: true);

          List<File> fileList = [];
          for (FileSystemEntity fileSystemEntity in messengerFiles) {
            fileList.add(File(fileSystemEntity.path));
          }
          context.read<AlbumProvider>().setFileToMessengerAlbum(fileList);

          // for (FileSystemEntity fileSystemEntity in todoFiles) {
          //   // ignore: use_build_context_synchronously
          //   context.read<AlbumProvider>().addFileToTodoAlbum(File(fileSystemEntity.path));
          // }
        }

        Future(() => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const LandingBottomNavigator())));
      } else if (response['result'] == 'FAIL') {
        if (response['code'] == "MalformedJwtException" ||
            response['code'] == "SignatureException" ||
            response['code'] == "ExpiredJwtException") {
          Future(() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AuthLandingScreen())));
        } else {
          Future(() => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const AuthLandingScreen())));
        }
      }
    }

    /// 회원가입 진행 중일 때 처리
    else if (PrefsUtil.getBool("is_register_progress") == true) {
      Future(() => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AuthRegisterScreen())));
    }

    /// 정보가 없을 때 처리
    else {
      Future(() => Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const AuthLandingScreen())));
    }
  }
}
