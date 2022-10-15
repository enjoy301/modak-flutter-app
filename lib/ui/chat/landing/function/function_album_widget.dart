import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/ui/common/common_image_screen.dart';
import 'package:modak_flutter_app/ui/common/common_video_screen.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';
import 'package:provider/provider.dart';

import '../../../../assets/icons/dark/DarkIcons_icons.dart';
import '../../../../constant/enum/chat_enum.dart';
import '../../../../utils/media_util.dart';

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
                    IconButton(
                      onPressed: () {
                        provider.setFunctionState(FunctionState.list);
                      },
                      icon: Icon(Icons.cancel_sharp),
                    ),
                    Expanded(
                      child: Center(
                        child: Text("보내고 싶은 사진 혹은 영상을 선택하세요"),
                      ),
                    ),
                    IconButton(
                      onPressed: () async {
                        if (provider.selectedMedias.isNotEmpty) {
                          MultipartFile zipFile = await compressFilesToZip(
                            provider.selectedMedias,
                          );

                          int counter = 0;
                          for (File file in provider.selectedMedias) {
                            log("selected media types -> ${file.path.mediaType()}");
                            if (file.path.mediaType() == "png" ||
                                file.path.mediaType() == "jpg") {
                              counter += 1;
                            }
                          }
                          provider.postMedia(zipFile, "zip", counter);

                          provider.clearSelectedMedia();
                          provider.setIsFunctionOpened(false);
                          provider.setFunctionState(FunctionState.list);
                        }
                      },
                      icon: IconGradientWidget(
                        provider.selectedMedias.isEmpty
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
                              File file = provider.getMediaAt(index);
                              bool isExist = false;
                              isExist = provider.removeSelectedMedia(file);
                              if (!isExist) {
                                provider.addSelectedMedia(file);
                              }
                            },
                            child: Stack(
                              children: [
                                Image.file(
                                  provider.getThumbnailMediaAt(index),
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
                                        value: provider.selectedMedias.contains(
                                            provider.getMediaAt(index)),
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
                                      print(
                                          "mediaType: ${provider.getMediaAt(index).toString().mediaType()}");
                                      // ignore: unrelated_type_equality_checks
                                      if (provider
                                              .getMediaAt(index)
                                              .toString()
                                              .mediaType() ==
                                          "mp4") {
                                        print("correcto");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommonVideoScreen(
                                              file: provider.getMediaAt(index),
                                            ),
                                          ),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CommonImageScreen(
                                              file: provider.getMediaAt(index),
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
