import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/provider/auth_provider.dart';
import 'package:modak_flutter_app/ui/auth/reigster/register_name_agreement_screen.dart';
import 'package:modak_flutter_app/ui/auth/reigster/register_role_screen.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
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
          resizeToAvoidBottomInset: false,
          appBar: headerDefaultWidget(
              title: "가족 생성",
              leading: FunctionalIcon.back,
              onClickLeading: () => {provider.goPreviousPage(context)}),
          body: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: pages[provider.page - 1]),
          bottomSheet: Container(
              color: Colors.white,
              width: double.infinity,
              height: 100,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
              child: ButtonMainWidget(
                title: buttonText[provider.page - 1],
                onPressed: () {
                  provider.goNextPage(context);
                },
                isValid: provider.getValidity(),
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
