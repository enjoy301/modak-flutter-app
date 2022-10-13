import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/data/dto/letter.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/chat/letter/chat_letter_VM.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/common/letter_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class LetterWriteEnvelopScreen extends StatefulWidget {
  const LetterWriteEnvelopScreen({Key? key}) : super(key: key);

  @override
  State<LetterWriteEnvelopScreen> createState() =>
      _LetterWriteEnvelopScreenState();
}

class _LetterWriteEnvelopScreenState extends State<LetterWriteEnvelopScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ChatLetterVM>(
        builder: (context, userProvider, provider, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: headerDefaultWidget(
            title: "봉투 선택",
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Get.back();
            }),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 200),
            child: Column(
              children: EnvelopeType.values.map((EnvelopeType envelop) {
                return LetterWidget(
                  letter: Letter(
                      fromMemberId: userProvider.me!.memberId,
                      toMemberId: provider.toMember!.memberId,
                      content: provider.content,
                      envelope: envelop,
                      date: DateFormat("yyyy.MM.dd").format(DateTime.now())),
                  onTap: () {
                    provider.envelope = envelop;
                  },
                  onSelected: provider.envelope == envelop,
                );
              }).toList(),
            ),
          ),
        ),
        bottomSheet: Padding(
          padding:
              const EdgeInsets.only(right: 30, left: 30, bottom: 16, top: 16),
          child: ButtonMainWidget(
            title: "편지 보내기",
            onPressed: () async {
              bool isSuccess = await provider.sendLetter(context);
              if (isSuccess) {
                Get.offAllNamed("/chat/letter/landing");
              }
            },
          ),
        ),
      );
    });
  }
}
