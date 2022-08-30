import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/utils/auth_util.dart';

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
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      AuthUtil.authRedirection(context, isLoad: true);
    });

    super.initState();

  }


}
