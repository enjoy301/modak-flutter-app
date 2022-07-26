import 'package:flutter/material.dart';
import 'package:modak_flutter_app/screens/auth/auth_landing_screen.dart';

class AuthSplashScreen extends StatefulWidget {
  const AuthSplashScreen({Key? key}) : super(key: key);

  @override
  State<AuthSplashScreen> createState() => _AuthSplashScreenState();
}

class _AuthSplashScreenState extends State<AuthSplashScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: Text("splash screen")),
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    navigateToNextPage();
  }

  navigateToNextPage() async {
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AuthLandingScreen()));
  }
}
