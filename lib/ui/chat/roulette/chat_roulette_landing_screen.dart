// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/chat/roulette/chat_roulette_result_screen.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/common/checkbox_widget.dart';
import 'package:modak_flutter_app/widgets/common/colored_safe_area.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class ChatRouletteLandingScreen extends StatefulWidget {
  const ChatRouletteLandingScreen({Key? key, this.title = ""})
      : super(key: key);

  final String title;

  @override
  State<ChatRouletteLandingScreen> createState() =>
      _ChatRouletteLandingScreenState();
}

class _ChatRouletteLandingScreenState extends State<ChatRouletteLandingScreen> {
  final int PENDING = 0;
  final int RUNNING = 1;
  final int DONE = 2;

  List<User> participatedUsers = [];
  final stream = BehaviorSubject<int>();
  late int result;
  late int state;

  String title = "";
  bool addTodo = false;
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    title = widget.title;
    _editingController.text = title;
    state = PENDING;
    super.initState();
  }

  @override
  void dispose() {
    stream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<UserProvider, TodoProvider, ChatProvider>(
      builder: (context, userProvider, todoProvider, chatProvider, child) {
        return ColoredSafeArea(
          color: Colors.white,
          child: Scaffold(
              backgroundColor: Colors.white,
              appBar: headerDefaultWidget(
                title: "돌림판",
                bgColor: Colors.white,
                leading: FunctionalIcon.back,
                onClickLeading: () {
                  Get.back();
                },
              ),
              body: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 32),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: userProvider.familyMembers
                                  .map((User familyMember) => SizedBox(
                                        width: 80,
                                        height: 90,
                                        child: Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                if (state != PENDING) {
                                                  return;
                                                }
                                                if (participatedUsers
                                                    .contains(familyMember)) {
                                                  participatedUsers
                                                      .remove(familyMember);
                                                } else {
                                                  participatedUsers
                                                      .add(familyMember);
                                                }
                                                setState(() {});
                                              },
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        10000),
                                                child: Stack(
                                                  children: [
                                                    Container(
                                                      width: 50,
                                                      height: 50,
                                                      color: familyMember.color
                                                          .toColor()!
                                                          .withOpacity(
                                                              participatedUsers
                                                                      .contains(
                                                                          familyMember)
                                                                  ? 0.9
                                                                  : 0.2),
                                                    ),
                                                    if (participatedUsers
                                                        .contains(familyMember))
                                                      Icon(
                                                        Icons.check,
                                                        size: 50,
                                                        color: Colors.white,
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.only(top: 12),
                                              child: Text(
                                                "${familyMember.name}\n",
                                                style: TextStyle(
                                                    height: 1.05,
                                                    color: Coloring.gray_0,
                                                    fontSize:
                                                        Font.size_smallText),
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24),
                          child: InputTextWidget(
                            hint: "할 일을 입력해주세요",
                            initText: title,
                            textEditingController: _editingController,
                            isBlocked: state != PENDING,
                            onChanged: (String text) {
                              setState(() {
                                title = text;
                              });
                            },
                            isSuffix: state == PENDING && title.isNotEmpty,
                            onClickSuffix: () {
                              setState(() {
                                title = "";
                              });
                            },
                          ),
                        ),
                        Container(
                          height: 300,
                          padding: EdgeInsets.only(top: 30),
                          child: FortuneWheel(
                            selected: stream.stream,
                            animateFirst: false,
                            items: [
                              ...participatedUsers
                                  .map(
                                    (User familyMember) => FortuneItem(
                                      child: Padding(
                                        padding: const EdgeInsets.only(left: 5),
                                        child: Text(
                                          familyMember.name,
                                        ),
                                      ),
                                      style: FortuneItemStyle(
                                          color: familyMember.color.toColor()!,
                                          borderWidth: 0),
                                    ),
                                  )
                                  .toList(),
                              if (participatedUsers.isEmpty)
                                FortuneItem(
                                    child: Text(""),
                                    style: FortuneItemStyle(
                                        color: Colors.grey,
                                        borderColor: Colors.grey,
                                        borderWidth: 3)),
                              if (participatedUsers.length < 2)
                                FortuneItem(
                                    child: Text(""),
                                    style: FortuneItemStyle(
                                        color: Colors.grey,
                                        borderColor: Colors.white)),
                            ],
                            onAnimationEnd: () {
                              setState(
                                () {
                                  state = DONE;
                                },
                              );
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      "${participatedUsers[stream.value].name}님이 당첨되셨습니다~"),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                              state == PENDING && participatedUsers.length < 2
                                  ? "최소 2명 이상 선택하세요"
                                  : ""),
                        ),
                        if (state == DONE)
                          TextButton(
                            onPressed: () {
                              Get.to(ChatRouletteResultScreen(
                                  title: title,
                                  addTodo: addTodo,
                                  participatedUsers: participatedUsers,
                                  selectedUser:
                                      participatedUsers[stream.value]));
                            },
                            child: Text(
                              "결과 확인하기",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: Font.size_largeText,
                                  fontWeight: Font.weight_semiBold),
                            ),
                          ),
                        if (state != DONE)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CheckboxWidget(
                                  value: addTodo,
                                  color: "orange",
                                  onChanged: (bool? value) {
                                    if (state != PENDING) {
                                      return;
                                    }
                                    setState(() {
                                      addTodo = value!;
                                    });
                                  }),
                              Padding(
                                padding: const EdgeInsets.only(left: 8),
                                child: Text(
                                  "할 일에 자동 등록",
                                  style: EasyStyle.text(Coloring.gray_10,
                                      Font.size_smallText, Font.weight_regular),
                                ),
                              )
                            ],
                          )
                      ],
                    ),
                  ),
                ),
              ),
              bottomSheet: state == PENDING
                  ? Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          right: 30, bottom: 24, left: 30),
                      child: ButtonMainWidget(
                        title: "돌려 돌려~",
                        color: Coloring.main,
                        shadow: Shadowing.yellow,
                        isValid:
                            title.isNotEmpty && participatedUsers.length > 1,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          int random =
                              Fortune.randomInt(0, participatedUsers.length);

                          chatProvider.postChat(
                            context,
                            "",
                            metaData: {
                              'type_code': "roulette",
                              'title': title,
                              'addTodo': addTodo,
                              'participatedUsers': participatedUsers
                                  .map((User participatedMember) => {
                                        'name': participatedMember.name,
                                        'color': participatedMember.color,
                                      })
                                  .toList(),
                              'selectedUser': {
                                'name': participatedUsers[random].name,
                                'color': participatedUsers[random].color,
                              }
                            },
                          );
                          bool isSuccess = true;
                          if (addTodo) {
                            isSuccess = await todoProvider.postTodo(
                              Todo(
                                todoId: -1,
                                groupTodoId: -1,
                                memberId: participatedUsers[random].memberId,
                                title: title,
                                color: "color",
                                memoColor: "color",
                                isDone: false,
                                timeTag: null,
                                repeatTag: null,
                                repeat: [0, 0, 0, 0, 0, 0, 0],
                                memo: null,
                                date: Date.getFormattedDate(),
                              ),
                            );
                          }
                          if (isSuccess) {
                            setState(
                              () {
                                stream.add(random);
                                state = RUNNING;
                              },
                            );
                          } else {
                            Fluttertoast.showToast(msg: "네트워크 상태를 확인해주세요");
                          }
                        },
                      ),
                    )
                  : null),
        );
      },
    );
  }
}
