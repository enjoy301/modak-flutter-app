import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/chat/letter/chat_letter_VM.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:provider/provider.dart';

class LetterWriteContentScreen extends StatelessWidget {
  const LetterWriteContentScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ChatLetterVM>(
        builder: (context, userProvider, provider, child) {
      return GestureDetector(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                child: Column(
                  children: [
                    Row(
                      children: [
                        ScalableTextWidget(
                          "To.  ",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Font.size_h3,
                            fontWeight: Font.weight_bold,
                          ),
                        ),
                        DropdownButton<User>(
                          items: userProvider.familyMembersWithoutMe
                              .map((User familyMember) {
                            return DropdownMenuItem<User>(
                              key: Key(familyMember.name),
                              alignment: Alignment.center,
                              value: familyMember,
                              child: Row(
                                children: [
                                  ScalableTextWidget(
                                    familyMember.name,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Font.size_largeText,
                                      fontWeight: Font.weight_bold,
                                    ),
                                  ),
                                ],
                              ),
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
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      minLines: 20,
                      maxLines: 200,
                      style: TextStyle(
                          fontSize: Font.size_mediumText *
                              userProvider.getFontScale()),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      onChanged: (String text) {
                        provider.content = text;
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Row(
                        children: [
                          Expanded(child: Text("")),
                          Text(
                            "From. ${userProvider.me?.name ?? "익명"}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: Font.size_h3,
                              fontWeight: Font.weight_bold,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Container(
              color: Coloring.gray_50,
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30, bottom: 16),
                child: ButtonMainWidget(
                    title: "편지 작성 완료!",
                    onPressed: () {
                      Get.toNamed("/letter/write/envelop");
                    },
                    isValid: provider.getFirstPageValidity()),
              )),
        ),
      );
    });
  }
}
