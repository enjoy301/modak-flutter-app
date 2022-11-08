import 'package:flutter/material.dart';
import 'package:modak_flutter_app/ui/auth/register/auth_register_VM.dart';
import 'package:modak_flutter_app/widgets/button/button_text_widget.dart';
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
                title: "회원가입",
                onClickLeading: () {
                  provider.goPreviousPage();
                }),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonTextWidget(
                      text: "이전",
                      onPressed: provider.goPreviousPage,
                      isColorStatic: true,
                    ),
                    ButtonTextWidget(
                      text: provider.getButtonText(),
                      isValid: provider.getIsPageDone(),
                      onPressed: () => provider.goNextPage(context),
                    ),
                  ],
                )),
          ),
        );
      });
    });
  }
}
