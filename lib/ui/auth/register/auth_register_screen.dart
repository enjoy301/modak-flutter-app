import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_VM.dart';
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
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthRegisterVM>(builder: (context, provider, child) {
      return FutureBuilder(future: Future<void>(() async {
        await provider.init();
        controller.value = TextEditingValue(text: provider.name);
      }), builder: (context, snapshot) {
        return WillPopScope(
          onWillPop: () {
            provider.goPreviousPage();
            return Future(() => false);
          },
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: headerDefaultWidget(
                title: "가족 생성",
                leading: FunctionalIcon.back,
                onClickLeading: () => {provider.goPreviousPage()}),
            body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: provider.getPage(provider, controller)),
            bottomSheet: Container(
                color: Colors.white,
                width: double.infinity,
                height: 100,
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                child: ButtonMainWidget(
                  title: provider.getButtonText(),
                  onPressed: () {
                    provider.goNextPage(context);
                  },
                  isValid: provider.getIsPageDone(),
                )),
          ),
        );
      });
    });
  }

  @override
  void initState() {
    PrefsUtil.setBool("is_register_progress", true);
    super.initState();
  }
}
