import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/ui/user/invitation/user_invitation_input_VM.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class UserInvitationInputScreen extends StatefulWidget {
  const UserInvitationInputScreen({Key? key}) : super(key: key);

  @override
  State<UserInvitationInputScreen> createState() => _UserInvitationInputScreenState();
}

class _UserInvitationInputScreenState extends State<UserInvitationInputScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<UserInvitationInputVM>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: headerDefaultWidget(
              trailing: FunctionalIcon.close,
              onClickTrailing: () {
                Get.back();
              }
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Expanded(flex: 1, child: SizedBox()),
                  Text("가족 코드를 입력해주세요", style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: Font.size_h4,
                    fontWeight: Font.weight_regular,
                    height: 3
                  )),
                  ConstrainedBox(
                    constraints: BoxConstraints(minWidth: 36),
                    child: IntrinsicWidth(
                      child: TextFormField(
                        onChanged: (String text) {
                          provider.familyCode = text;
                        },
                        cursorColor: Colors.grey[600],
                        decoration: InputDecoration(
                          hintText: "코드 입력",
                          border: InputBorder.none,
                          hintStyle: TextStyle(
                            color: Colors.grey[400],
                            fontSize: Font.size_subTitle,
                            fontWeight: Font.weight_regular,
                          )
                        ),
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: SizedBox()),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(top: 16, bottom: 48, right: 30, left: 30),
            child: ButtonMainWidget(title: "가족 연결하기", onPressed: () async {
              bool isSuccessful = await provider.updateFamilyCode();
              if (isSuccessful) {
                Get.offAllNamed("/auth/splash");
              }
            }, isValid: provider.familyCode.length > 3,),
          ),
        );
      }
    );
  }
}
