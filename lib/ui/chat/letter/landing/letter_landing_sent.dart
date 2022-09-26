import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/chat/letter/chat_letter_VM.dart';
import 'package:modak_flutter_app/ui/chat/letter/landing/chat_letter_detail_screen.dart';
import 'package:modak_flutter_app/widgets/common/letter_widget.dart';
import 'package:provider/provider.dart';

class LetterLandingSent extends StatelessWidget {
  const LetterLandingSent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ChatLetterVM>(
      builder: (context, userProvider, provider, child) {
        return RefreshIndicator(
          onRefresh: () async {
            await provider.getLetters(context);
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            body: ListView.builder(itemCount: provider.lettersSent.length, itemBuilder: (context, index) {
              return LetterWidget(
                  letter: provider.lettersSent[index], onTap: () {
                    Get.to(ChatLetterDetailScreen(letter: provider.lettersSent[index]));
              },);
            }),
          ),
        );
      }
    );
  }
}
