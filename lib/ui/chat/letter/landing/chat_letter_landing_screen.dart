import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
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
  late Future initial;

  @override
  Widget build(BuildContext context) {
    return Consumer2<ChatLetterVM, UserProvider>(
      builder: (context, provider, userProvider, child) {
        return FutureBuilder(
          future: initial,
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                          tabs: [
                            Tab(
                              child: Text("받은"),
                            ),
                            Tab(
                              child: Text("보낸"),
                            ),
                          ],
                          isScrollable: true,
                          labelPadding: EdgeInsets.only(left: 10, right: 10),
                          labelStyle: TextStyle(
                              color: Colors.black,
                              fontSize:
                                  Font.size_h3 * userProvider.getFontScale(),
                              fontWeight: Font.weight_bold),
                          labelColor: Colors.black,
                          unselectedLabelColor: Coloring.gray_20,
                          indicator: UnderlineTabIndicator(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                body: TabBarView(
                  children: [
                    LetterLandingReceived(),
                    LetterLandingSent(),
                  ],
                ),
                floatingActionButton: GestureDetector(
                  onTap: () {
                    Get.toNamed("/letter/write");
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
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initial = context.read<ChatLetterVM>().getLetters();
  }
}
