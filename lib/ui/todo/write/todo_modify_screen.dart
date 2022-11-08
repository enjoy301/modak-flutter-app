import 'package:collection/collection.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_modify_VM.dart';
import 'package:modak_flutter_app/ui/todo/write/todo_write_when_screen.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_date_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_select_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';
import 'package:provider/provider.dart';

class TodoModifyScreen extends StatefulWidget {
  const TodoModifyScreen({Key? key, required this.todo, required this.isAfterUpdate}) : super(key: key);

  final Todo todo;
  final bool isAfterUpdate;

  @override
  State<TodoModifyScreen> createState() => _TodoModifyScreenState();
}

class _TodoModifyScreenState extends State<TodoModifyScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController memoController = TextEditingController();
  bool loaded = false;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TodoModifyVM(),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Consumer2<UserProvider, TodoModifyVM>(builder: (context, userProvider, provider, child) {
          return FutureBuilder(future: Future<void>(() async {
            if (!loaded) {
              loaded = true;
              provider.todo = widget.todo;
              provider.manager = userProvider.findUserById(provider.todo.memberId);
              provider.isAfterUpdate = widget.isAfterUpdate;
              titleController.text = provider.todo.title;
              memoController.text = provider.todo.memo ?? "";
              titleController.selection = TextSelection.fromPosition(TextPosition(offset: titleController.text.length));
              provider.notify();
            }
          }), builder: (context, snapshot) {
            return Scaffold(
              backgroundColor: Colors.white,
              appBar: headerDefaultWidget(
                  title: "할 일 수정하기",
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
                              "수정 목록",
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
                              provider.todo.title = text;
                              provider.notify();
                            },
                            textEditingController: titleController,
                            hint: "할 일 이름",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 13),
                          child: InputSelectWidget(
                              title: "담당",
                              contents: provider.manager == null ? userProvider.me!.name : provider.manager!.name,
                              buttons: userProvider.familyMembers.mapIndexed((int index, User familyMember) {
                                return TextButton(
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.symmetric(vertical: 20),
                                    foregroundColor:
                                        MaterialStateColor.resolveWith((states) => familyMember.color.toColor()!),
                                    backgroundColor: familyMember.color.toColor()!.withOpacity(0.2),
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(index == 0 ? 10 : 0),
                                            bottom: Radius.circular(
                                                index == userProvider.familyMembers.length - 1 ? 10 : 0))),
                                  ),
                                  onPressed: () {
                                    provider.manager = familyMember;
                                    Get.back();
                                  },
                                  child: Text(
                                    familyMember.name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: Font.size_mediumText,
                                        fontWeight: Font.weight_medium),
                                  ),
                                );
                              }).toList(),
                              leftIconData: LightIcons.Profile),
                        ),
                        provider.todo.repeatTag == null
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 13),
                                child: InputDateWidget(
                                    title: "날짜",
                                    contents: provider.todo.date,
                                    onChanged: (DateTime dateTime) {
                                      provider.todo.date = DateFormat("yyyy-MM-dd").format(dateTime);
                                      provider.notify();
                                    },
                                    minTime: DateTime.now().subtract(Duration(days: 400)),
                                    maxTime: DateTime.now().add(Duration(days: 400)),
                                    currTime: DateTime.parse(provider.todo.date)),
                              )
                            : SizedBox(
                                height: 0,
                                width: 0,
                              ),
                        InputSelectWidget(
                          title: "언제",
                          contents: provider.todo.timeTag ?? "언제든지",
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            dynamic result = await Get.to(
                                TodoWriteWhenScreen(
                                  previousTag: provider.todo.timeTag,
                                  isTimeSelected: provider.isTimeSelected,
                                ),
                                preventDuplicates: false);
                            if (result[1].runtimeType == String) {
                              provider.isTimeSelected = result[0];
                              provider.todo.timeTag = result[1];
                              provider.notify();
                            }
                          },
                          leftIconData: LightIcons.TimeCircle,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                              textEditingController: memoController,
                              onChanged: (String text) {
                                provider.todo.memo = text;
                                provider.notify();
                              },
                              hint: "할 일 내용",
                              minLines: 2,
                              maxLines: 15,
                            ),
                          ],
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
                  title: "수정",
                  isValid: provider.todo.title.trim().isNotEmpty,
                  onPressed: () async {
                    bool isSuccess = await provider.updateTodo(context);
                    if (isSuccess) Get.back();
                  },
                ),
              ),
            );
          });
        }),
      ),
    );
  }
}
