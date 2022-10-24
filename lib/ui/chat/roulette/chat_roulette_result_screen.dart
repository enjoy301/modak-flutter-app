import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:rxdart/rxdart.dart';

class ChatRouletteResultScreen extends StatefulWidget {
  const ChatRouletteResultScreen(
      {Key? key,
      required this.title,
      required this.addTodo,
      required this.participatedUsers,
      required this.selectedUser})
      : super(key: key);

  final String title;
  final bool addTodo;
  final List<User> participatedUsers;
  final User selectedUser;

  @override
  State<ChatRouletteResultScreen> createState() =>
      _ChatRouletteResultScreenState();
}

class _ChatRouletteResultScreenState extends State<ChatRouletteResultScreen> {
  final stream = BehaviorSubject<int>();

  @override
  void initState() {
    stream.add(widget.participatedUsers.indexOf(widget.selectedUser));
    super.initState();
  }

  @override
  void dispose() {
    stream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: headerDefaultWidget(
        title: "돌림판 결과",
        leading: FunctionalIcon.back,
        onClickLeading: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Text(
                "룰렛 주제",
                style: TextStyle(
                  color: Coloring.gray_0,
                  fontSize: Font.size_subTitle,
                  fontWeight: Font.weight_semiBold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Text(
                widget.title,
                style: TextStyle(
                  color: Coloring.gray_0,
                  fontSize: Font.size_h2,
                  fontWeight: Font.weight_semiBold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: SizedBox(
                height: 300,
                child: FortuneWheel(
                  selected: stream,
                  rotationCount: 1,
                  items: widget.participatedUsers
                      .map((User familyMember) => FortuneItem(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              familyMember.name,
                            ),
                          ),
                          style: FortuneItemStyle(
                              color: familyMember.color
                                  .toColor()!
                                  .withOpacity(0.7),
                              borderColor: Colors.white)))
                      .toList(),
                ),
              ),
            ),
            Column(
                children: widget.participatedUsers
                    .map((User user) => Row(
                          children: [
                            Flexible(
                                flex: 1,
                                fit: FlexFit.tight,
                                child: Text(
                                  user.name,
                                  style: TextStyle(
                                      color:
                                          user.name == widget.selectedUser.name
                                              ? user.color.toColor()
                                              : Coloring.gray_10,
                                      fontSize: Font.size_largeText,
                                      fontWeight: Font.weight_medium),
                                  textAlign: TextAlign.center,
                                )),
                            Icon(
                              Icons.arrow_right_alt_sharp,
                              size: 30,
                              color: user.name == widget.selectedUser.name
                                  ? user.color.toColor()
                                  : Coloring.gray_10,
                            ),
                            Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                user.name == widget.selectedUser.name
                                    ? "당첨"
                                    : "꽝",
                                style: TextStyle(
                                    color: user.name == widget.selectedUser.name
                                        ? user.color.toColor()
                                        : Coloring.gray_10,
                                    fontSize: Font.size_largeText,
                                    fontWeight: Font.weight_medium),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ))
                    .toList()),
            if (widget.addTodo)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "집안일에 추가되었습니다!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: Font.size_mediumText,
                      fontWeight: Font.weight_medium),
                ),
              )
          ],
        ),
      ),
    );
  }
}
