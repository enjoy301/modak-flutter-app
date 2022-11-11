import 'package:flutter/gestures.dart';
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
  late LongPressDownDetails _longPressDownDetails;

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
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
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
                          title: "할 일을 완료하셨나요?",
                          des: "확인을 누르면 채팅방에 알림이 보내집니다.\n다시 취소 할 수 없어요.",
                          onOkPress: () {
                        todoProvider.doneTodo(todo, !todo.isDone);
                      });
                    } else {
                      Fluttertoast.cancel();
                      Fluttertoast.showToast(
                        msg: "이미 완료했습니다.",
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
                          'name': "수정하기",
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
                                  "단일 변경": () {
                                    Get.back();
                                    Get.to(TodoModifyScreen(
                                        todo: todo, isAfterUpdate: false));
                                  },
                                  "이후 변경": () {
                                    Get.back();
                                    Get.to(TodoModifyScreen(
                                        todo: todo, isAfterUpdate: true));
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
                          'name': '삭제하기',
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
                                  "단일 변경": () {
                                    Get.back();
                                    todoProvider.deleteTodo(todo, false);
                                  },
                                  "이후 변경": () {
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
                            'name': '감사 표현하기',
                            'icon': Icon(
                              LightIcons.Heart,
                              color: Colors.black,
                            ),
                            'onTap': () {
                              NotificationController.sendNotification(
                                "감사 표현",
                                "${userProvider.me!.name}님이 ${userProvider.findUserById(todo.memberId)?.name ?? "당신"}에게 감사를 표 합니다",
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todo.title,
                                      style: EasyStyle.text(
                                          mainColor,
                                          Font.size_largeText,
                                          Font.weight_semiBold),
                                    ),
                                    TodoListItemTagWidget(
                                      name: todo.timeTag ?? "언제든지",
                                      color: mainColor,
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "@${userProvider.findUserById(todo.memberId)?.name ?? "익명"}",
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
                                style: EasyStyle.text(memoColor,
                                    Font.size_smallText, Font.weight_medium),
                              ),
                            ),
                          SizedBox.shrink()
                        ],
                      ),
                    ),
                  ),
                );
              }),
        ),
      );
    });
  }
}
