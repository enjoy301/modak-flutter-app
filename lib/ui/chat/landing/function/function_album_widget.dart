import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/common/common_medias_screen.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/common/checkbox_widget.dart';
import 'package:modak_flutter_app/widgets/common/media_widget.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';
import 'package:provider/provider.dart';

import '../../../../assets/icons/dark/DarkIcons_icons.dart';
import '../../../../constant/enum/chat_enum.dart';

class FunctionAlbumWidget extends StatefulWidget {
  const FunctionAlbumWidget({Key? key}) : super(key: key);

  @override
  State<FunctionAlbumWidget> createState() => _FunctionAlbumWidget();
}

class _FunctionAlbumWidget extends State<FunctionAlbumWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return SizedBox(
          height: 350,
          child: Column(
            children: [
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    /// row 1번 취소 버튼
                    IconButton(
                      onPressed: () {
                        provider.chatMode = ChatMode.functionList;
                        provider.clearSelectedMedia();
                      },
                      icon: Icon(LightIcons.CloseSquare),
                    ),

                    /// row 2번 앨범 소개 텍스트
                    Expanded(
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            style: EasyStyle.text(Coloring.gray_0,
                                Font.size_largeText, Font.weight_medium),
                            children: <TextSpan>[
                              if (provider.selectedMediaFiles.isEmpty)
                                TextSpan(text: "보내고 싶은 사진 혹은 영상을 선택하세요"),
                              if (provider.selectedMediaFiles.isNotEmpty)
                                TextSpan(
                                  children: <TextSpan>[
                                    TextSpan(text: "현재 "),
                                    TextSpan(
                                        text: provider.selectedMediaFiles.length
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: Font.weight_bold,
                                            color: Colors.purpleAccent[700])),
                                    TextSpan(text: "개가 선택 되었습니다."),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    /// row 3번 전송 버튼
                    IconButton(
                      onPressed: () async {
                        provider.postMediaFiles(context);
                      },
                      icon: IconGradientWidget(
                        provider.selectedMediaFiles.isEmpty
                            ? LightIcons.Send
                            : DarkIcons.Send,
                        25,
                        Coloring.sub_purple,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.albumFiles.length,
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 10,
                    );
                  },
                  itemBuilder: (BuildContext context, int index) {
                    return Flex(
                      direction: Axis.vertical,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              File file = provider.albumFiles[index];
                              if (provider.isExistFile(file)) {
                                provider.removeSelectedMedia(file);
                              } else {
                                if (provider.selectedMediaFiles.length < 10) {
                                  provider.addSelectedMedia(file);
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "한 번에 최대 10개까지 전송할 수 있습니다.");
                                }
                              }
                            },
                            child: Stack(
                              children: [
                                /// 썸네일
                                MediaWidget(
                                  file: provider.albumFiles[index],
                                  boxFit: BoxFit.cover,
                                  width: 160,
                                  radius: 12,
                                  height: double.infinity,
                                ),

                                /// 가장자리 border
                                Container(
                                  width: 160,
                                  decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    border: Border.all(
                                        color: provider.selectedMediaFiles
                                                .contains(
                                          provider.albumFiles[index],
                                        )
                                            ? Coloring.todo_purple
                                            : Colors.transparent,
                                        width: 4),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),

                                /// 우 상단 체크 박스
                                Positioned(
                                  top: 9,
                                  right: 9,
                                  child: CheckboxWidget(
                                    color: "purple",
                                    value: provider.selectedMediaFiles.contains(
                                      provider.albumFiles[index],
                                    ),
                                    onChanged: (bool? value) {},
                                  ),
                                ),

                                /// 상세 보기 아이콘
                                Positioned(
                                  bottom: 9,
                                  left: 9,
                                  child: IconButton(
                                    onPressed: () {
                                      // ignore: unrelated_type_equality_checks
                                      if (provider.albumFiles[index].path
                                                  .mediaType() ==
                                              "mp4" ||
                                          provider.albumFiles[index].path
                                                  .mediaType() ==
                                              "mov") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommonMediasScreen(
                                              initialIndex: index,
                                              files: provider.albumFiles,
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommonMediasScreen(
                                                    initialIndex: index,
                                                    files: provider.albumFiles),
                                          ),
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      LightIcons.Search,
                                      size: 25,
                                      color: Colors.blue[400],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
