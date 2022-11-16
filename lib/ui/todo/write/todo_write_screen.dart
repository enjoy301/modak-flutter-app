import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_write_when_screen.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_date_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_select_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';
import 'package:modak_flutter_app/widgets/todo/todo_day_week_widget.dart';
import 'package:provider/provider.dart';

class TodoWriteScreen extends StatefulWidget {
  const TodoWriteScreen({Key? key, this.title, this.manager, this.date})
      : super(key: key);

  final String? title;
  final User? manager;
  final DateTime? date;

  @override
  State<TodoWriteScreen> createState() => _TodoWriteScreenState();
}

class _TodoWriteScreenState extends State<TodoWriteScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController memoController = TextEditingController();

  @override
  void initState() {
    title = widget.title ?? "";
    manager = widget.manager;
    date = widget.date ?? DateTime.now();
    super.initState();
  }

  String title = "";
  User? manager;
  DateTime date = DateTime.now();
  String? timeTag;
  List<int> repeat = [0, 0, 0, 0, 0, 0, 0];
  String? memo;

  bool isTimeSelected = false;

  void toggleRepeat(int index) {
    repeat[index] = repeat[index] == 1 ? 0 : 1;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Consumer2<UserProvider, TodoProvider>(
          builder: (context, userProvider, todoProvider, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: headerDefaultWidget(
              title: "할 일 추가하기",
              leading: FunctionalIcon.back,
              onClickLeading: () {
                Navigator.pop(context);
              },
              bgColor: Colors.white),
          body: SingleChildScrollView(
            child: ExpandableNotifier(
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          "기본 설정",
                          style: TextStyle(
                            color: Coloring.gray_10,
                            fontSize: Font.size_mediumText,
                            fontWeight: Font.weight_semiBold,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: InputTextWidget(
                        autofocus: true,
                        isSatisfied: title.trim().isNotEmpty,
                        onChanged: (String text) {
                          setState(() {
                            title = text;
                          });
                        },
                        textEditingController: titleController,
                        hint: "할 일 이름",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: InputSelectWidget(
                          title: "담당",
                          contents: manager == null
                              ? userProvider.me!.name
                              : manager!.name,
                          isFilled: true,
                          buttons: {
                            for (User familyMember
                                in userProvider.familyMembers)
                              familyMember.name: () {
                                setState(() {
                                  manager = familyMember;
                                });
                                Get.back();
                              }
                          },
                          leftIconData: LightIcons.Profile),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 13),
                      child: InputDateWidget(
                          title: "날짜",
                          contents: Date.getFormattedDate(dateTime: date),
                          onChanged: (DateTime dateTime) {
                            setState(() {
                              date = dateTime;
                            });
                          },
                          minTime: DateTime.now().subtract(Duration(days: 400)),
                          maxTime: DateTime.now().add(Duration(days: 400)),
                          currTime: date),
                    ),
                    InputSelectWidget(
                      title: "언제",
                      contents: timeTag ?? "언제든지",
                      isFilled: timeTag != null,
                      onTap: () async {
                        FocusScope.of(context).requestFocus(FocusNode());
                        dynamic result = await Get.to(
                            TodoWriteWhenScreen(
                              previousTag: timeTag,
                              isTimeSelected: isTimeSelected,
                            ),
                            preventDuplicates: false);
                        if (result[1].runtimeType == String) {
                          setState(() {
                            isTimeSelected = result[0];
                            timeTag = result[1];
                          });
                        }
                      },
                      leftIconData: LightIcons.TimeCircle,
                    ),
                    ExpandableButton(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "추가 설정",
                              style: TextStyle(
                                color: Coloring.gray_10,
                                fontSize: Font.size_mediumText,
                                fontWeight: Font.weight_semiBold,
                              ),
                            ),
                            Expandable(
                              collapsed: Icon(LightIcons.ArrowDown2),
                              expanded: Icon(
                                LightIcons.ArrowUp2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expandable(
                      theme: ExpandableThemeData(
                        animationDuration: Duration(milliseconds: 1),
                      ),
                      collapsed: Text(""),
                      expanded: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5, bottom: 8),
                            child: Text(
                              "반복",
                              style: TextStyle(
                                color: Coloring.gray_10,
                                fontSize: Font.size_smallText,
                                fontWeight: Font.weight_regular,
                              ),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                TodoDayWeekWidget(
                                  dayOfTheWeek: DayOfTheWeek.sun,
                                  isEnabled: repeat[0] == 1,
                                  onPressed: () {
                                    toggleRepeat(0);
                                  },
                                ),
                                TodoDayWeekWidget(
                                  dayOfTheWeek: DayOfTheWeek.mon,
                                  isEnabled: repeat[1] == 1,
                                  onPressed: () {
                                    toggleRepeat(1);
                                  },
                                ),
                                TodoDayWeekWidget(
                                  dayOfTheWeek: DayOfTheWeek.tue,
                                  isEnabled: repeat[2] == 1,
                                  onPressed: () {
                                    toggleRepeat(2);
                                  },
                                ),
                                TodoDayWeekWidget(
                                  dayOfTheWeek: DayOfTheWeek.wed,
                                  isEnabled: repeat[3] == 1,
                                  onPressed: () {
                                    toggleRepeat(3);
                                  },
                                ),
                                TodoDayWeekWidget(
                                  dayOfTheWeek: DayOfTheWeek.thu,
                                  isEnabled: repeat[4] == 1,
                                  onPressed: () {
                                    toggleRepeat(4);
                                  },
                                ),
                                TodoDayWeekWidget(
                                  dayOfTheWeek: DayOfTheWeek.fri,
                                  isEnabled: repeat[5] == 1,
                                  onPressed: () {
                                    toggleRepeat(5);
                                  },
                                ),
                                TodoDayWeekWidget(
                                  dayOfTheWeek: DayOfTheWeek.sat,
                                  isEnabled: repeat[6] == 1,
                                  onPressed: () {
                                    toggleRepeat(6);
                                  },
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 24, bottom: 8),
                            child: Text("메모 (옵션)",
                                style: TextStyle(
                                  color: Coloring.gray_10,
                                  fontSize: Font.size_smallText,
                                  fontWeight: Font.weight_regular,
                                )),
                          ),
                          InputTextWidget(
                            isSatisfied: true,
                            textEditingController: memoController,
                            onChanged: (String text) {
                              memo = text;
                            },
                            hint: "메모 입력",
                            minLines: 2,
                            maxLines: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(
              top: 20,
              left: 30,
              right: 30,
              bottom: 20 + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: ButtonMainWidget(
              title: "등록",
              isValid: title.trim().isNotEmpty,
              color: Coloring.main,
              shadow: Shadowing.yellow,
              onPressed: () async {
                if (await todoProvider.postTodo(Todo(
                    todoId: -1,
                    groupTodoId: -1,
                    memberId: manager == null ? -1 : manager!.memberId,
                    title: title,
                    color: userProvider.me!.color,
                    isDone: false,
                    timeTag: timeTag,
                    repeatTag: "null",
                    repeat: repeat,
                    memo: memo?.trim(),
                    memoColor: 'null',
                    date: Date.getFormattedDate(dateTime: date)))) Get.back();
              },
            ),
          ),
        );
      }),
    );
  }
}
