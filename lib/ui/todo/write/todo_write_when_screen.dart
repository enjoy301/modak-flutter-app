import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/date.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class TodoWriteWhenScreen extends StatefulWidget {
  const TodoWriteWhenScreen({
    Key? key,
    this.isTimeSelected = false,
    required this.previousTag,
  }) : super(key: key);

  final bool isTimeSelected;
  final String? previousTag;

  @override
  State<TodoWriteWhenScreen> createState() => _TodoWriteWhenScreenState();
}

class _TodoWriteWhenScreenState extends State<TodoWriteWhenScreen> {
  final List<String> defaultTimeTag = [
    "눈 뜨자 마자",
    "출근 길에",
    "저녁 먹기 전까지",
    "퇴근하자마자",
    "퇴근 후",
    "나갈 때",
    "상시",
    "밥 먹고",
    "자기 전 체크",
    "침대에서",
  ];

  String? selectedTag;
  bool isTimeSelected = false;
  String timeSelectTag = "시간 선택";

  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    selectedTag = widget.previousTag;
    isTimeSelected = widget.isTimeSelected;
    timeSelectTag = isTimeSelected ? selectedTag ?? "시간 선택" : "시간 선택";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return WillPopScope(
        onWillPop: () async {
          Get.back(result: [isTimeSelected, selectedTag]);
          return false;
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            if (_textEditingController.text.isNotEmpty) {
              userProvider.addMeTag(_textEditingController.text);
              _textEditingController.clear();
            }
          },
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: headerDefaultWidget(
                bgColor: Colors.white,
                title: "언제 할래요?",
                leading: FunctionalIcon.back,
                onClickLeading: () {
                  Get.back(result: [isTimeSelected, selectedTag]);
                }),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimeTagWidget(timeSelectTag,
                        provider: userProvider,
                        isSelected: isTimeSelected, onPressed: () {
                      DatePicker.showTime12hPicker(context,
                          onConfirm: (DateTime dateTime) {
                        String text = Date.getFormattedDate(
                            format: "hh:mm a", dateTime: dateTime);

                        setState(() {
                          isTimeSelected = true;
                          timeSelectTag = text;
                          selectedTag = text;
                        });
                      }, locale: LocaleType.ko);
                    }),
                    Wrap(
                      children: defaultTimeTag.map((timeTag) {
                            return TimeTagWidget(
                              timeTag,
                              provider: userProvider,
                              isSelected: selectedTag == timeTag,
                              onPressed: () {
                                setState(() {
                                  isTimeSelected = false;
                                  selectedTag = timeTag;
                                });
                              },
                            ) as Widget;
                          }).toList() +
                          userProvider.me!.timeTags
                              .map((timeTag) => TimeTagWidget(timeTag,
                                      provider: userProvider,
                                      isCustom: true,
                                      isSelected: selectedTag == timeTag,
                                      onPressed: () {
                                    setState(() {
                                      selectedTag = timeTag;
                                    });
                                  }))
                              .toList() +
                          [
                            TimeTagWriteWidget(
                              provider: userProvider,
                              textEditingController: _textEditingController,
                            ),
                          ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}

class TimeTagWriteWidget extends StatefulWidget {
  const TimeTagWriteWidget(
      {required this.provider, required this.textEditingController, Key? key})
      : super(key: key);

  final UserProvider provider;
  final TextEditingController textEditingController;

  @override
  State<TimeTagWriteWidget> createState() => _TimeTagWriteWidgetState();
}

class _TimeTagWriteWidgetState extends State<TimeTagWriteWidget> {
  String text = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 14),
          decoration: BoxDecoration(
            color: Coloring.gray_50,
            borderRadius: BorderRadius.circular(59),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 48),
            child: IntrinsicWidth(
              child: TextFormField(
                onChanged: (String changedText) {
                  setState(() {
                    text = changedText;
                  });
                },
                onEditingComplete: () {
                  if (text == "") {
                    Fluttertoast.showToast(msg: "글자를 입력해주세요");
                  } else {
                    widget.provider.addMeTag(text);
                    widget.textEditingController.clear();
                    FocusScope.of(context).unfocus();
                  }
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Font.size_smallText * userProvider.getFontScale(),
                  fontWeight: Font.weight_regular,
                  height: 1,
                ),
                controller: widget.textEditingController,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                  hintText: "+ 추가",
                  hintStyle: TextStyle(
                    color: Coloring.gray_10,
                    fontSize: Font.size_smallText * userProvider.getFontScale(),
                    fontWeight: Font.weight_regular,
                    height: 1,
                  ),
                  counterText: "",
                  border: InputBorder.none,
                ),
                maxLength: 12,
              ),
            ),
          ),
        ),
      );
    });
  }
}

class TimeTagWidget extends StatelessWidget {
  const TimeTagWidget(this.title,
      {Key? key,
      required this.provider,
      required this.isSelected,
      required this.onPressed,
      this.isCustom = false})
      : super(key: key);
  final UserProvider provider;
  final String title;
  final bool isSelected;
  final Function() onPressed;
  final bool isCustom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 11, horizontal: 14),
          decoration: BoxDecoration(
            color: Coloring.gray_50,
            gradient: isSelected ? Coloring.main : null,
            borderRadius: BorderRadius.circular(59),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ScalableTextWidget(
                title,
                style: TextStyle(
                  color: isSelected ? Colors.white : Coloring.gray_10,
                  fontSize: Font.size_smallText,
                  fontWeight:
                      isSelected ? Font.weight_semiBold : Font.weight_regular,
                  height: 1,
                ),
              ),
              isCustom == true
                  ? IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      onPressed: () async {
                        OkCancelResult result = await showOkCancelAlertDialog(
                          context: context,
                          title: "삭제하시겠습니까?",
                          okLabel: "삭제",
                          cancelLabel: "취소",
                        );
                        if (result == OkCancelResult.ok) {
                          provider.removeMeTag(title);
                        }
                      },
                      icon: Icon(
                        Icons.close,
                        size: 15,
                        color: Coloring.gray_10,
                      ),
                    )
                  : Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
