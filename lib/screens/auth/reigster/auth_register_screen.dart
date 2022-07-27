import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:modak_flutter_app/screens/auth/reigster/register_name_agreement_screen.dart';
import 'package:modak_flutter_app/screens/auth/reigster/register_role_screen.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:modak_flutter_app/widgets/header/header_blank_widget.dart';
import 'package:provider/provider.dart';

class AuthRegisterScreen extends StatefulWidget {
  const AuthRegisterScreen({Key? key}) : super(key: key);

  @override
  State<AuthRegisterScreen> createState() => _AuthRegisterScreenState();
}

class _AuthRegisterScreenState extends State<AuthRegisterScreen> {
  final List<StatefulWidget> pages = [
    RegisterNameAgreementScreen(),
    RegisterRoleScreen(),
  ];
  final List<String> buttonText = [
    "다음으로",
    "회원가입",
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(builder: (context, provider, child) {
      return WillPopScope(
        onWillPop: () {
          provider.goPreviousPage(context);
          return Future(() => false);
        },
        child: Scaffold(
          appBar: headerBlankWidget(
              "회원가입", () => {provider.goPreviousPage(context)}),
          body: pages[provider.page - 1],
          bottomSheet: Container(
              width: double.infinity,
              height: 60,
              margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: ElevatedButton(
                onPressed: provider.getValidity()
                    ? () {
                        provider.goNextPage(context);
                      }
                    : null,
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
                child: Text(buttonText[provider.page - 1]),
              )),
        ),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    PrefsUtil.setBool("is_register_progress", true);
  }
}
