import 'package:flutter/material.dart';
import 'package:modak_flutter_app/screens/auth/reigster/auth_register_screen.dart';

class AuthLandingScreen extends StatefulWidget {
  const AuthLandingScreen({Key? key}) : super(key: key);

  @override
  State<AuthLandingScreen> createState() => _AuthLandingScreenState();
}

class _AuthLandingScreenState extends State<AuthLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AuthRegisterScreen()));
              },
              child: Text("회원가입으로 이동"),
            ),
          ],
        ),
      ),
    );
  }
}
