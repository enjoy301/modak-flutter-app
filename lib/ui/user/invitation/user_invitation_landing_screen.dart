import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class UserInvitationLandingScreen extends StatelessWidget {
  const UserInvitationLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
        trailing: FunctionalIcon.close,
        onClickTrailing: () {
          Get.back();
        }
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return Column(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  Clipboard.setData(ClipboardData(text: homeProvider.familyCode));
                  Fluttertoast.showToast(msg: "클립보드에 복사되었습니다.");
                },
                child: Text(
                  homeProvider.familyCode ?? "", style: TextStyle(
                ),
                ),
              )
            ],
          );
        }
      ),
    );
  }
}
