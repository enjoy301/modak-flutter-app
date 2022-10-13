import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_modify_screen.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/modal/default_modal_widget.dart';
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
    return Consumer<TodoProvider>(builder: (context, provider, _) {
      List<Todo> todos = provider.todoMap[
              DateFormat("yyyy-MM-dd").format(provider.selectedDateTime)] ??
          [];
      return Expanded(
        child: ListView.builder(
          padding: EdgeInsets.only(bottom: 200),
          shrinkWrap: true,
          itemCount: todos.length,
          itemBuilder: (context, index) {
            Todo todo = todos[index];
            return ExpandableNotifier(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 300,
                        margin: EdgeInsets.only(left: 10, right: 12),
                        child: GestureDetector(
                          onTap: () {
                            provider.doneTodo(todo, !todo.isDone);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            decoration: BoxDecoration(
                              color: todo.isDone
                                  ? Coloring.gray_50
                                  : todos[index]
                                      .color
                                      .toColor()
                                      ?.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 7,
                                      height: 7,
                                      margin: EdgeInsets.only(right: 16),
                                      decoration: BoxDecoration(
                                        color: todo.isDone
                                            ? Coloring.gray_20
                                            : todo.color.toColor(),
                                        borderRadius:
                                            BorderRadius.circular(1000),
                                      ),
                                    ),
                                    ScalableTextWidget(todos[index].title,
                                        style: TextStyle(
                                            color: todo.isDone
                                                ? Coloring.gray_20
                                                : Coloring.gray_10,
                                            fontSize: Font.size_mediumText,
                                            fontWeight: Font.weight_semiBold,
                                            decoration: todo.isDone
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                            decorationThickness: 3,
                                            decorationColor: Coloring.gray_20)),
                                    Expanded(
                                      child: Text(""),
                                    ),
                                    todo.memo != ""
                                        ? ExpandableButton(
                                            child: Expandable(
                                              theme: ExpandableThemeData(
                                                  animationDuration: Duration(
                                                      microseconds: 0)),
                                              collapsed: Container(
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                child: Icon(
                                                  LightIcons.ArrowDown2,
                                                  color: todo.isDone
                                                      ? Coloring.gray_20
                                                      : Coloring.gray_10,
                                                  size: 16,
                                                ),
                                              ),
                                              expanded: Container(
                                                padding: EdgeInsets.zero,
                                                constraints: BoxConstraints(),
                                                child: Icon(
                                                  LightIcons.ArrowUp2,
                                                  color: todo.isDone
                                                      ? Coloring.gray_20
                                                      : Coloring.gray_10,
                                                  size: 16,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Text(""),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    todo.timeTag != null
                                        ? TodoListItemTagWidget(
                                            name: todo.timeTag!)
                                        : SizedBox(
                                            height: 0,
                                          ),
                                    todo.repeatTag != null
                                        ? TodoListItemTagWidget(
                                            name: todo.repeatTag!)
                                        : SizedBox(
                                            height: 0,
                                          ),
                                  ],
                                ),
                                Expandable(
                                  theme: ExpandableThemeData(
                                    animationDuration:
                                        Duration(microseconds: 1),
                                  ),
                                  expanded: Text(todo.memo ?? "",
                                      style: TextStyle(
                                        color: todo.isDone
                                            ? Coloring.gray_20
                                            : Coloring.gray_10,
                                        fontSize: Font.size_smallText,
                                        fontWeight: Font.weight_medium,
                                      ),
                                      textAlign: TextAlign.left),
                                  collapsed: SizedBox(
                                    height: 0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          defaultModalWidget(
                            context,
                            [
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                    if (todo.repeatTag != null) {
                                      defaultModalWidget(context, [
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.to(TodoModifyScreen(
                                                todo: todo,
                                                isAfterUpdate: false,
                                              ));
                                            },
                                            child: Text("단일 변경")),
                                        TextButton(
                                            onPressed: () {
                                              Get.back();
                                              Get.to(TodoModifyScreen(
                                                todo: todo,
                                                isAfterUpdate: true,
                                              ));
                                            },
                                            child: Text("이후 변경"))
                                      ]);
                                    } else {
                                      Get.to(TodoModifyScreen(
                                        todo: todo,
                                        isAfterUpdate: false,
                                      ));
                                    }
                                  },
                                  child: Text("수정하기")),
                              TextButton(
                                  onPressed: () {
                                    Get.back();
                                    if (todo.repeatTag != null) {
                                      defaultModalWidget(context, [
                                        TextButton(
                                            onPressed: () {
                                              provider.deleteTodo(todo, false);
                                              Get.back();
                                            },
                                            child: Text("단일 삭제")),
                                        TextButton(
                                            onPressed: () {
                                              provider.deleteTodo(todo, true);
                                              Get.back();
                                            },
                                            child: Text("이후 삭제"))
                                      ]);
                                    } else {
                                      provider.deleteTodo(todo, false);
                                    }
                                  },
                                  child: Text("삭제하기"))
                            ],
                          );
                        },
                        icon: Icon(
                          Icons.more_vert,
                          size: 14,
                        ),
                        padding: EdgeInsets.only(top: 12),
                        constraints: BoxConstraints())
                  ],
                ),
              ),
            );
          },
        ),
      );
    });
  }
}
