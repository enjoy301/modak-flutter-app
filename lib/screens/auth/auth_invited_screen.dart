import 'package:flutter/material.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';

class AuthInvitedScreen extends StatelessWidget {
  const AuthInvitedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerDefaultWidget(),
    );
  }
}
