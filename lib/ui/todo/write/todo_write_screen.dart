import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_write_VM.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_write_when_screen.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_date_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_select_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';
import 'package:modak_flutter_app/widgets/todo/todo_day_week_widget.dart';
import 'package:provider/provider.dart';

class TodoWriteScreen extends StatelessWidget {
  const TodoWriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController memoController = TextEditingController();

    return ChangeNotifierProvider(
        create: (_) => TodoWriteVM(),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Consumer2<UserProvider, TodoWriteVM>(
              builder: (context, userProvider, provider, child) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: headerDefaultWidget(
                  title: "할 일 추가하기",
                  leading: FunctionalIcon.back,
                  onClickLeading: () {
                    Navigator.pop(context);
                  }),
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
                            onChanged: (String text) {
                              provider.title = text;
                            },
                            textEditingController: titleController,
                            hint: "할 일 이름",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: InputSelectWidget(
                              title: "담당",
                              contents: provider.manager == null
                                  ? userProvider.me!.name
                                  : provider.manager!.name,
                              buttons: userProvider.familyMembers
                                  .map((User familyMember) {
                                return TextButton(
                                  onPressed: () {
                                    provider.manager = familyMember;
                                    Get.back();
                                  },
                                  child: Container(
                                      color: familyMember.color.toColor(),
                                      child: Text(familyMember.name)),
                                );
                              }).toList(),
                              leftIconData: LightIcons.Profile),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: InputDateWidget(
                              title: "날짜",
                              contents: DateFormat("yyyy-MM-dd")
                                  .format(provider.date),
                              onChanged: (DateTime dateTime) {
                                provider.date = dateTime;
                              },
                              minTime:
                                  DateTime.now().subtract(Duration(days: 400)),
                              maxTime: DateTime.now().add(Duration(days: 400)),
                              currTime: DateTime.now()),
                        ),
                        InputSelectWidget(
                          title: "언제",
                          contents: provider.timeTag ?? "언제든지",
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            dynamic result = await Get.to(TodoWriteWhenScreen(
                              previousTag: provider.timeTag,
                            ));
                            if (result.runtimeType == String) {
                              provider.timeTag = result;
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
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 8),
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
                                      isEnabled: provider.repeat[0] == 1,
                                      onPressed: () {
                                        provider.toggleRepeat(0);
                                      },
                                    ),
                                    TodoDayWeekWidget(
                                      dayOfTheWeek: DayOfTheWeek.mon,
                                      isEnabled: provider.repeat[1] == 1,
                                      onPressed: () {
                                        provider.toggleRepeat(1);
                                      },
                                    ),
                                    TodoDayWeekWidget(
                                      dayOfTheWeek: DayOfTheWeek.tue,
                                      isEnabled: provider.repeat[2] == 1,
                                      onPressed: () {
                                        provider.toggleRepeat(2);
                                      },
                                    ),
                                    TodoDayWeekWidget(
                                      dayOfTheWeek: DayOfTheWeek.wed,
                                      isEnabled: provider.repeat[3] == 1,
                                      onPressed: () {
                                        provider.toggleRepeat(3);
                                      },
                                    ),
                                    TodoDayWeekWidget(
                                      dayOfTheWeek: DayOfTheWeek.thu,
                                      isEnabled: provider.repeat[4] == 1,
                                      onPressed: () {
                                        provider.toggleRepeat(4);
                                      },
                                    ),
                                    TodoDayWeekWidget(
                                      dayOfTheWeek: DayOfTheWeek.fri,
                                      isEnabled: provider.repeat[5] == 1,
                                      onPressed: () {
                                        provider.toggleRepeat(5);
                                      },
                                    ),
                                    TodoDayWeekWidget(
                                      dayOfTheWeek: DayOfTheWeek.sat,
                                      isEnabled: provider.repeat[6] == 1,
                                      onPressed: () {
                                        provider.toggleRepeat(6);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 24, bottom: 8),
                                child: Text("메모 (옵션)",
                                    style: TextStyle(
                                      color: Coloring.gray_10,
                                      fontSize: Font.size_smallText,
                                      fontWeight: Font.weight_regular,
                                    )),
                              ),
                              InputTextWidget(
                                textEditingController: memoController,
                                onChanged: (String text) {
                                  provider.memo = text;
                                },
                                hint: "할 일 내용",
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
                  isValid: provider.getIsValid(),
                  onPressed: () async {
                    if (await provider.postTodo(context)) Get.back();
                  },
                ),
              ),
            );
          }),
        ));
  }
}
