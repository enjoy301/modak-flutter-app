import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';

class UserInvitationInputScreen extends StatelessWidget {
  const UserInvitationInputScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerDefaultWidget(
          trailing: FunctionalIcon.close,
          onClickTrailing: () {
            Get.back();
          }
      ),
    );
  }
}
