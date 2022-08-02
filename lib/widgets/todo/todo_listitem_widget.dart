import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:modak_flutter_app/models/todo_model.dart';
import 'package:modak_flutter_app/widgets/dialog/default_dialog_widget.dart';
import 'package:modak_flutter_app/widgets/todo/todo_listitem_tag_widget.dart';

class TodoListItemWidget extends StatelessWidget {
  const TodoListItemWidget({Key? key, required this.todo}) : super(key: key);

  final TodoModel todo;

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
      initialExpanded: false,
      child: Row(
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(top: 5, bottom: 5, left: 20, right: 2),
              decoration: BoxDecoration(
                  color: Colors.pinkAccent,
                  borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: 10,
                            height: 10,
                            decoration: BoxDecoration(
                              color: Colors.cyan,
                              borderRadius: BorderRadius.circular(5),
                            ),
                          ),
                        ),
                        Text(todo.title),
                        Expanded(child: Text("")),
                        ExpandableButton(
                          child: Icon(Icons.keyboard_arrow_down_rounded),
                        )
                      ],
                    ),
                    Expandable(
                        collapsed: Container(
                          height: 0,
                        ),
                        expanded: (Text(todo.desc))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TodoListItemTagWidget(name: todo.tags[0]),
                        TodoListItemTagWidget(name: todo.tags[1]),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          IconButton(onPressed: () {DefaultDialogWidget(context);}, icon: Icon(Icons.more_vert)),
        ],
      ),
    );
  }
}

