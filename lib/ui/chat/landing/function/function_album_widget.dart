import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/common/common_medias_screen.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
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
                        provider.setChatMode(ChatMode.functionList);
                        provider.clearSelectedMedia();
                      },
                      icon: Icon(Icons.cancel_sharp),
                    ),

                    /// row 2번 앨범 소개 텍스트
                    Expanded(
                      child: Center(
                        child: Text("보내고 싶은 사진 혹은 영상을 선택하세요"),
                      ),
                    ),

                    /// row 3번 전송 버튼
                    IconButton(
                      onPressed: () async {
                        provider.postMediaFilesFromAlbum();
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
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: provider.thumbnailMedias.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Flex(
                      direction: Axis.vertical,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              File file = provider.mediaFiles[index];
                              provider.isExistFile(file)
                                  ? provider.removeSelectedMedia(file)
                                  : provider.addSelectedMedia(file);
                            },
                            child: Stack(
                              children: [
                                Image.file(
                                  provider.thumbnailMedias[index],
                                  width: 160,
                                  height: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Positioned(
                                  top: 9,
                                  right: 9,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      gradient: Coloring.sub_purple,
                                    ),
                                    child: Theme(
                                      data: ThemeData(
                                        unselectedWidgetColor:
                                            Color(0x00F6DFDF),
                                      ),
                                      child: Checkbox(
                                        activeColor: Color(0x00F6DFDF),
                                        value: provider.selectedMediaFiles
                                            .contains(
                                          provider.mediaFiles[index],
                                        ),
                                        onChanged: (bool? value) {},
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 9,
                                  left: 9,
                                  child: IconButton(
                                    onPressed: () {
                                      // ignore: unrelated_type_equality_checks
                                      if (provider.mediaFiles[index]
                                              .toString()
                                              .mediaType() ==
                                          "mp4") {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommonMediasScreen(
                                              files: [
                                                provider.mediaFiles[index]
                                              ],
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommonMediasScreen(
                                              files: [
                                                provider.mediaFiles[index]
                                              ],
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    icon: IconGradientWidget(LightIcons.Search,
                                        25, Coloring.sub_blue),
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
