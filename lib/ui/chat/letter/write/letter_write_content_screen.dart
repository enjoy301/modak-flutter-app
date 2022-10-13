import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/chat/letter/chat_letter_VM.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class LetterWriteContentScreen extends StatelessWidget {
  const LetterWriteContentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ChatLetterVM>(
        builder: (context, userProvider, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: headerDefaultWidget(
            title: "편지 작성",
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Get.back();
            }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "To. ",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: Font.size_h3,
                        fontWeight: Font.weight_regular,
                      ),
                    ),
                    DropdownButton<User>(
                      items: userProvider.familyMembersWithoutMe
                          .map((User familyMember) {
                        return DropdownMenuItem<User>(
                          key: Key(familyMember.name),
                          value: familyMember,
                          child: Text(familyMember.name),
                        );
                      }).toList(),
                      onChanged: (value) {
                        provider.toMember = value;
                      },
                      value: provider.toMember,
                    ),
                  ],
                ),
                TextField(
                  minLines: 20,
                  maxLines: 200,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  onChanged: (String text) {
                    provider.content = text;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 60),
                  child: Row(
                    children: [
                      Expanded(child: Text("")),
                      Text(
                        "From. ${userProvider.me?.name ?? "익명"}",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: Font.size_h3,
                          fontWeight: Font.weight_regular,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(right: 30, left: 30, bottom: 16),
              child: ButtonMainWidget(
                  title: "편지 작성 완료!",
                  onPressed: () {
                    Get.toNamed("/letter/write/envelop");
                  },
                  isValid: provider.getFirstPageValidity()),
            )),
      );
    });
  }
}
