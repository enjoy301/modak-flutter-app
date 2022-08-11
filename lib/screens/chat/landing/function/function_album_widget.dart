import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:modak_flutter_app/screens/common/common_image_screen.dart';
import 'package:modak_flutter_app/screens/common/common_video_screen.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/widgets/icon/icon_gradient_widget.dart';
import 'package:provider/provider.dart';

class FunctionAlbumWidget extends StatefulWidget {
  const FunctionAlbumWidget({Key? key}) : super(key: key);

  @override
  State<FunctionAlbumWidget> createState() => _FunctionAlbumWidgetState();
}

class _FunctionAlbumWidgetState extends State<FunctionAlbumWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
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
                                    unselectedWidgetColor: Color(0x00F6DFDF),
                                  ),
                                  child: Checkbox(
                                    activeColor: Color(0x00F6DFDF),
                                    value: provider.selectedMedias
                                        .contains(provider.getMediaAt(index)),
                                    onChanged: (bool? value) {},
                                  ),
                                ))),
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
                                                    file: provider
                                                        .getMediaAt(index))));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CommonImageScreen(
                                                    file: provider
                                                        .getMediaAt(index))));
                                  }
                                },
                                icon: IconGradientWidget(
                                    LightIcons.Search, 25, Coloring.sub_blue)))
                      ],
                    ),
                  ),
                )
              ],
            );
          },
        );
      },
    );
  }

  @override
  bool get wantKeepAlive => true;
}
