import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/shadowing.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_write_screen.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_date_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_select_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';
import 'package:provider/provider.dart';

class FunctionTodoWidget extends StatefulWidget {
  const FunctionTodoWidget({Key? key}) : super(key: key);

  @override
  State<FunctionTodoWidget> createState() => _FunctionTodoWidgetState();
}

class _FunctionTodoWidgetState extends State<FunctionTodoWidget> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  Todo todo = Todo(
    todoId: -1,
    groupTodoId: -1,
    memberId: -1,
    title: '',
    color: 'color',
    isDone: false,
    timeTag: null,
    repeatTag: null,
    repeat: [0, 0, 0, 0, 0, 0, 0],
    memo: null,
    memoColor: 'default',
    date: Date.getFormattedDate(),
  );

  @override
  Widget build(BuildContext context) {
    return Consumer3<ChatProvider, UserProvider, TodoProvider>(
      builder: (context, chatProvider, userProvider, todoProvider, child) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: InputTextWidget(
                  initText: context.read<ChatProvider>().todoTitle,
                  textEditingController: _textEditingController,
                  isBlocked: true,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InputSelectWidget(
                  leftIconData: LightIcons.Profile,
                  title: "담당",
                  contents: "",
                  isFilled: true,
                  buttons: {
                    for (User family in userProvider.familyMembers)
                      family.name: () {
                        Get.back();
                      }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InputDateWidget(
                  title: "날짜",
                  contents: todo.date,
                  onChanged: (DateTime dateTime) {
                    setState(() {
                      todo.date = Date.getFormattedDate(dateTime: dateTime);
                    });
                  },
                  currTime: DateTime.parse(todo.date),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: InputSelectWidget(
                  leftIconData: LightIcons.MoreCircle,
                  title: "옵션 더보기",
                  contents: "",
                  isFilled: false,
                  onTap: () {
                    Get.to(TodoWriteScreen(
                      title: chatProvider.todoTitle,
                    ));
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: ButtonMainWidget(
                  height: 50,
                  title: "일정 등록하기",
                  isValid: todo.title.trim().isNotEmpty,
                  onPressed: () async {
                    if (await todoProvider.postTodo(todo)) ;
                  },
                  color: Coloring.main,
                  shadow: Shadowing.yellow,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
