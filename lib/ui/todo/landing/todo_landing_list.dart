import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_modify_screen.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/utils/notification_controller.dart';
import 'package:modak_flutter_app/widgets/common/pressed_timer_widget.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/modal/list_modal_widget.dart';
import 'package:modak_flutter_app/widgets/modal/theme_modal_widget.dart';
import 'package:modak_flutter_app/widgets/modal/theme_position_list_widget.dart';
import 'package:modak_flutter_app/widgets/todo/todo_listitem_tag_widget.dart';
import 'package:provider/provider.dart';

class TodoLandingList extends StatefulWidget {
  const TodoLandingList({Key? key}) : super(key: key);

  @override
  State<TodoLandingList> createState() => _TodoLandingListState();
}

class _TodoLandingListState extends State<TodoLandingList> {
  @override
  void initState() {
    super.initState();
    context.read<TodoProvider>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TodoProvider, UserProvider>(
        builder: (context, todoProvider, userProvider, _) {
      List<Todo> todos = todoProvider.todoMap[
              DateFormat("yyyy-MM-dd").format(todoProvider.selectedDateTime)] ??
          [];
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: RefreshIndicator(
            onRefresh: () async {
              todoProvider.getTodosByScroll(null);
            },
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  if (todos.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text(
                        "?????? ????????? ??? ?????? ????????????",
                        style: EasyStyle.text(Coloring.gray_20,
                            Font.size_mediumText, Font.weight_medium),
                      ),
                    ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: todos.length,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        Todo todo = todos[index];
                        Color mainColor =
                            todo.isDone ? Coloring.gray_30 : Coloring.gray_10;
                        Color memoColor =
                            todo.isDone ? Coloring.gray_20 : Coloring.gray_10;
                        return PressedTimerWidget(
                          duration: Duration(milliseconds: 400),
                          onTap: () {
                            if (!todo.isDone) {
                              themeModalWidget(context,
                                  title: "??? ?????? ???????????????????",
                                  des: "????????? ????????? ????????? ???????????????.\n?????? ?????? ??? ??? ?????????.",
                                  onOkPress: () {
                                todoProvider.doneTodo(todo, !todo.isDone);
                                NotificationController.sendNotification(
                                    "${todo.title}??? ?????????????????????\n",
                                    '${todo.title}??? ${userProvider.findUserById(todo.memberId)?.name ?? "(????????????)"}?????? ?????????????????????! \n????????? ????????? ?????? ?????????????',
                                    'todo');
                              });
                            } else {
                              Fluttertoast.cancel();
                              Fluttertoast.showToast(
                                msg: "?????? ??????????????????.",
                              );
                            }
                          },
                          onTimePressed: (details) {
                            HapticFeedback.lightImpact();
                            themePositionListWidget(
                              context,
                              details: details,
                              itemList: [
                                {
                                  'name': "????????????",
                                  'icon': Icon(
                                    LightIcons.EditSquare,
                                    color: Colors.black,
                                  ),
                                  'onTap': () {
                                    Get.back();
                                    if (todo.repeatTag != null) {
                                      listModalWidget(
                                        context,
                                        {
                                          "?????? ??????": () {
                                            Get.back();
                                            Get.to(TodoModifyScreen(
                                                todo: todo,
                                                isAfterUpdate: false));
                                          },
                                          "?????? ??????": () {
                                            Get.back();
                                            Get.to(TodoModifyScreen(
                                                todo: todo,
                                                isAfterUpdate: true));
                                          },
                                        },
                                      );
                                    } else {
                                      Get.to(TodoModifyScreen(
                                          todo: todo, isAfterUpdate: false));
                                    }
                                  },
                                },
                                {
                                  'name': '????????????',
                                  'icon': Icon(
                                    LightIcons.CloseSquare,
                                    color: Colors.black,
                                  ),
                                  'onTap': () {
                                    Get.back();
                                    if (todo.repeatTag != null) {
                                      listModalWidget(
                                        context,
                                        {
                                          "?????? ??????": () {
                                            Get.back();
                                            todoProvider.deleteTodo(
                                                todo, false);
                                          },
                                          "?????? ??????": () {
                                            Get.back();
                                            todoProvider.deleteTodo(todo, true);
                                          },
                                        },
                                      );
                                    } else {
                                      todoProvider.deleteTodo(todo, false);
                                    }
                                  },
                                },
                                if (todo.isDone &&
                                    todo.memberId != userProvider.me!.memberId)
                                  {
                                    'name': '?????? ????????????',
                                    'icon': Icon(
                                      LightIcons.Heart,
                                      color: Colors.black,
                                    ),
                                    'onTap': () {
                                      NotificationController.sendNotification(
                                        "??? ?????? ?????? ?????? ??????",
                                        "${userProvider.me!.name}?????? ${userProvider.findUserById(todo.memberId)?.name ?? "??????"}?????? ????????? ?????? ???????????????",
                                        'todo',
                                      );
                                      Get.back();
                                    }
                                  }
                              ],
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.all(15),
                                    color: Colors.white,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ScalableTextWidget(
                                              todo.title,
                                              style: EasyStyle.text(
                                                  mainColor,
                                                  Font.size_largeText,
                                                  Font.weight_semiBold),
                                            ),
                                            TodoListItemTagWidget(
                                              name: todo.timeTag ?? "????????????",
                                              color: mainColor,
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ScalableTextWidget(
                                                  "@${userProvider.findUserById(todo.memberId)?.name ?? "??????"}",
                                                  style: EasyStyle.text(
                                                      mainColor,
                                                      Font.size_smallText,
                                                      Font.weight_bold)),
                                              Text(
                                                todo.repeatTag ?? "",
                                                style: EasyStyle.text(
                                                    mainColor,
                                                    Font.size_smallText,
                                                    Font.weight_regular),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (todo.memo != "" && todo.memo != null)
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(15),
                                      color: todo.memoColor.toColor(),
                                      child: Text(
                                        todo.memo!,
                                        style: EasyStyle.text(
                                            memoColor,
                                            Font.size_smallText,
                                            Font.weight_medium),
                                      ),
                                    ),
                                  SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
