import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/ui/chat/letter/chat_letter_VM.dart';
import 'package:modak_flutter_app/ui/chat/letter/landing/letter_landing_received.dart';
import 'package:modak_flutter_app/ui/chat/letter/landing/letter_landing_sent.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class ChatLetterLandingScreen extends StatefulWidget {
  const ChatLetterLandingScreen({Key? key}) : super(key: key);

  @override
  State<ChatLetterLandingScreen> createState() =>
      _ChatLetterLandingScreenState();
}

class _ChatLetterLandingScreenState extends State<ChatLetterLandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatLetterVM>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: Future(() async {
            if (provider.letters.isEmpty) {
              await provider.getLetters(context);
            }
          }),
          builder: (context, snapshot) {
            return DefaultTabController(
              length: 2,
              child: Scaffold(
                  appBar: headerDefaultWidget(
                    title: "우편함",
                    leading: FunctionalIcon.back,
                    onClickLeading: () {
                      Get.back();
                    },
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(40),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          tabs: [Tab(child: Text("보낸")), Tab(child: Text("받은"))],
                          isScrollable: true,
                          indicator: UnderlineTabIndicator(
                            insets: EdgeInsets.only(bottom: 10),
                          ),
                          labelPadding: EdgeInsets.symmetric(horizontal: 20),
                          indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(
                    children: [LetterLandingSent(), LetterLandingReceived()],
                  ),
                floatingActionButton:
                  GestureDetector(
                    onTap: () {
                      Get.toNamed("/letter/write/content");
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        gradient: Coloring.sub_purple,
                        boxShadow: [
                          Shadowing.purple,
                        ],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                ),
                  ),
              ),
            );
          }
        );
      }
    );
  }
}
