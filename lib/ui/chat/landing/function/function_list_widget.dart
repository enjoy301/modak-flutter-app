import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/utils/media_util.dart';
import 'package:modak_flutter_app/widgets/chat/chat_function_icon_widget.dart';
import 'package:modak_flutter_app/widgets/modal/list_modal_widget.dart';
import 'package:provider/provider.dart';

class FunctionListWidget extends StatefulWidget {
  const FunctionListWidget({Key? key}) : super(key: key);

  @override
  State<FunctionListWidget> createState() => _FunctionListWidget();
}

class _FunctionListWidget extends State<FunctionListWidget> {
  final List<Map<String, String>> topics = [
    {"가족 퀴즈": "아빠와 엄마 혹은 남편과 아내분의 첫 데이트 한 장소는 어딜까요??"},
    {"가족 퀴즈": "엄마가 가장 좋아하는 음식은?"},
    {"가족 퀴즈": "아빠가 가장 좋아하는 음식은?"},
    {"가족 대화": "다들 오늘 계획은 어떻게 되시나요? 아니면 오늘 하루 어떻게 보내셨나요?"},
    {"가족 대화": "가족에게 감사한 점이 있다면?"},
    {"가족 대화": "요즘 가장 큰 고민거리는 무엇인가요?"},
    {"가족 대화": "다음 휴가 때 어디로 가지..."},
    {"가족 대화": "각자 겪었던 재밌는 일은 무엇이 있나요?"},
    {"가족 대화": "가족한테 고마웠던 경험은?"},
    {"가족 대화": "요즘 관심사를 한 번 말해볼까요?"},
    {"가족 대화": "지금 가장 듣고 싶은 말은?"},
    {"가족 대화": "그동안 살면서 가장 기억에 남는 것은?"},
    {"가족 대화": "가장 슬펐던 일은?"},
    {"가족 대화": "가족에게 가장 바라는 것은?"},
    {"가족 대화": "앞으로의 소원과 다짐을 공유해봅시다"},
  ];
  final List<Map<String, dynamic>> functionIconWidgetValues = [
    {
      'name': "앨범",
      'icon': LightIcons.Image,
      'color': Coloring.bg_pink,
    },
    {
      'name': "카메라",
      'icon': LightIcons.Camera,
      'color': Coloring.bg_red,
    },
    {
      'name': "오는 길에",
      'icon': LightIcons.Work,
      'color': Coloring.bg_orange,
    },
    {
      'name': "룰렛",
      'icon': LightIcons.TicketStar,
      'color': Coloring.bg_yellow,
    },
    {
      'name': "편지",
      'icon': LightIcons.Message,
      'color': Coloring.point_pureorange
    },
    {
      'name': "주제 던지기",
      'icon': LightIcons.Chat,
      'color': Coloring.todo_lightgreen
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer2<UserProvider, ChatProvider>(
      builder: (context, userProvider, chatProvider, build) {
        /// 가족이 없을 때
        if (userProvider.familyMembers.length == 1) {
          return Container(
            width: double.infinity,
            height: 300,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    top: 48,
                    bottom: 32,
                  ),
                  child: Text(
                    "가족들과 함께 모닥의 기능들을 이용해보세요",
                    style: EasyStyle.text(Coloring.gray_10,
                        Font.size_mediumText, Font.weight_medium),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.toNamed("/user/invitation/landing");
                  },
                  child: Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          "lib/assets/images/others/il_letter.png",
                          width: 50,
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12),
                          child: Text(
                            "가족을 초대하세요",
                            style: EasyStyle.text(Colors.black,
                                Font.size_mediumText, Font.weight_medium),
                          ),
                        ),
                        Expanded(child: SizedBox.shrink()),
                        Icon(Icons.keyboard_arrow_right),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        }

        /// 가족이 있을 때
        return Container(
          height: 300,
          color: Colors.white,
          child: GridView(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.8,
              crossAxisCount: 4,
            ),
            children: [
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[0],
                onTap: () async {
                  if (chatProvider.albumFiles.isEmpty) {
                    List<File> files = await getImageFromAlbum();
                    await chatProvider.loadAlbum(files);
                  }
                  chatProvider.chatMode = ChatMode.functionAlbum;
                },
              ),
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[1],
                onTap: () async {
                  listModalWidget(
                    context,
                    {
                      "사진 찍기": () async {
                        Future(() => Navigator.pop(context));
                        File? image = await getImageFromCamera();

                        if (image != null) {
                          Fluttertoast.showToast(msg: "카메라 접근 에러");
                          chatProvider.addSelectedMedia(image);
                          chatProvider.postMediaFiles(context, isLocal: true);
                        }
                      },
                      "동영상 촬영": () async {
                        Future(() => Navigator.pop(context));
                        File? video = await getVideoFromCamera();

                        if (video != null) {
                          Fluttertoast.showToast(msg: "카메라 접근 에러");
                          chatProvider.addSelectedMedia(video);
                          chatProvider.postMediaFiles(context, isLocal: true);
                        }
                      },
                    },
                  );
                },
              ),
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[2],
                onTap: () {
                  log("오는 길에~");
                  chatProvider.chatMode = ChatMode.functionOnway;
                },
              ),
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[3],
                onTap: () {
                  log("룰렛 돌리기~");
                  Get.toNamed("/chat/roulette/landing");
                },
              ),
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[4],
                onTap: () {
                  Get.toNamed("/chat/letter/landing");
                },
              ),
              ChatFunctionIconWidget(
                data: functionIconWidgetValues[5],
                onTap: () {
                  int idx = math.Random().nextInt(topics.length);
                  Iterable<MapEntry<String, String>> entry =
                      topics[idx].entries;
                  chatProvider.postChat(
                    context,
                    entry.first.value,
                    metaData: {
                      "type_code": "topic",
                      "title": entry.first.key,
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
