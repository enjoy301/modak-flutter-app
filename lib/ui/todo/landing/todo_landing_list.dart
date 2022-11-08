import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_modify_screen.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/modal/list_modal_widget.dart';
import 'package:modak_flutter_app/widgets/todo/todo_listitem_tag_widget.dart';
import 'package:provider/provider.dart';

class TodoLandingList extends StatefulWidget {
  const TodoLandingList({Key? key}) : super(key: key);

  @override
  State<TodoLandingList> createState() => _TodoLandingListState();
}

class _TodoLandingListState extends State<TodoLandingList> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<TodoProvider, UserProvider>(builder: (context, todoProvider, userProvider, _) {
      List<Todo> todos = todoProvider.todoMap[DateFormat("yyyy-MM-dd").format(todoProvider.selectedDateTime)] ?? [];
      return Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: todos.length,
              itemBuilder: (BuildContext context, int index) {
                Todo todo = todos[index];
                return GestureDetector(
                  onTap: () {},
                  onLongPress: () {
                    listModalWidget(
                      context,
                      {
                        "수정 하기": () {
                          Get.back();
                          if (todo.repeatTag != null) {
                            listModalWidget(context, {
                              "단일 변경": () {
                                Get.back();
                                Get.to(
                                    TodoModifyScreen(
                                      todo: todo,
                                      isAfterUpdate: false,
                                    ),
                                    preventDuplicates: false);
                              },
                              "이후 변경": () {
                                Get.back();
                                Get.to(
                                    TodoModifyScreen(
                                      todo: todo,
                                      isAfterUpdate: true,
                                    ),
                                    preventDuplicates: false);
                              }
                            });
                          } else {
                            Get.to(TodoModifyScreen(
                              todo: todo,
                              isAfterUpdate: false,
                            ));
                          }
                        },
                        "삭제 하기": () {
                          Get.back();
                          if (todo.repeatTag != null) {
                            listModalWidget(context, {
                              "단일 삭제": () {
                                Get.back();
                                todoProvider.deleteTodo(todo, false);
                              },
                              "이후 삭제": () {
                                Get.back();
                                todoProvider.deleteTodo(todo, true);
                              }
                            });
                          } else {
                            todoProvider.deleteTodo(todo, false);
                          }
                        },
                      },
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
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      todo.title,
                                      style:
                                          EasyStyle.text(Coloring.gray_10, Font.size_largeText, Font.weight_semiBold),
                                    ),
                                    TodoListItemTagWidget(
                                      name: todo.timeTag ?? "언제든지",
                                    )
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("@${userProvider.findUserById(todo.memberId)?.name ?? "익명"}",
                                          style:
                                              EasyStyle.text(Coloring.gray_10, Font.size_smallText, Font.weight_bold)),
                                      Text(
                                        todo.repeatTag ?? "",
                                        style:
                                            EasyStyle.text(Coloring.gray_10, Font.size_smallText, Font.weight_regular),
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
                              color: todo.color.toColor()!.withOpacity(0.2),
                              child: Text(
                                todo.memo!,
                                style: EasyStyle.text(Coloring.gray_10, Font.size_smallText, Font.weight_medium),
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
