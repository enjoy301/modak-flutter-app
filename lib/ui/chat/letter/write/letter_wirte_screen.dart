import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/ui/chat/letter/chat_letter_VM.dart';
import 'package:modak_flutter_app/ui/chat/letter/write/letter_write_content_screen.dart';
import 'package:modak_flutter_app/ui/chat/letter/write/letter_write_envelop_screen.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/common/colored_safe_area.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class LetterWriteScreen extends StatefulWidget {
  const LetterWriteScreen({Key? key}) : super(key: key);

  @override
  State<LetterWriteScreen> createState() => _LetterWriteScreenState();
}

class _LetterWriteScreenState extends State<LetterWriteScreen> {
  final List<Map> pageInfo = [
    {"title": "편지 작성", "page": LetterWriteContentScreen(), "buttonTitle": "작성 완료", "onPressed": () {}},
    {"title": "봉투 선택", "page": LetterWriteEnvelopScreen(), "buttonTitle": "편지 보내기", "onPressed": () {}},
  ];

  final List<Widget> pages = [LetterWriteContentScreen(), LetterWriteEnvelopScreen()];

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatLetterVM>(builder: (context, provider, child) {
      return ColoredSafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: headerDefaultWidget(
                title: pageInfo[index]['title'],
                leading: FunctionalIcon.back,
                onClickLeading: () {
                  if (index == 0) {
                    Get.back();
                  } else {
                    index -= 1;
                    setState(() {});
                  }
                }),
            body: pages[index],
            bottomSheet: Padding(
              padding: const EdgeInsets.only(right: 30, left: 30, bottom: 16, top: 16),
              child: ButtonMainWidget(
                title: pageInfo[index]['buttonTitle'],
                isValid: provider.getFirstPageValidity() || index == 1,
                onPressed: () async {
                  if (index == 0) {
                    index += 1;
                    setState(() {});
                    return;
                  }
                  if (index == 1) {
                    bool isSuccess = await provider.sendLetter(context);
                    if (isSuccess) {
                      Get.back();
                    }
                  }
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
