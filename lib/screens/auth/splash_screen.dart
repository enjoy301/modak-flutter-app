import 'package:flutter/material.dart';
import 'package:modak_flutter_app/screens/landing_bottomtab_navigator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LandingBottomNavigator()));
  }
}
