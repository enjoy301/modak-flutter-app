import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/widgets/common/colored_safe_area.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

import '../../ui/common/common_medias_screen.dart';

class AlbumFaceDetailWidget extends StatefulWidget {
  const AlbumFaceDetailWidget({Key? key, required this.indexImage})
      : super(key: key);

  final File indexImage;

  @override
  State<AlbumFaceDetailWidget> createState() => _AlbumFaceDetailWidget();
}

class _AlbumFaceDetailWidget extends State<AlbumFaceDetailWidget> {
  var value = Get.arguments;
  late Future initial;

  @override
  Widget build(BuildContext context) {
    ScrollController faceScrollController = ScrollController();

    return Consumer<AlbumProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: headerDefaultWidget(title: "인물별 모아보기", bgColor: Colors.white),
          body: ColoredSafeArea(
            color: Colors.white,
            child: FutureBuilder(
              future: initial,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 40),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(1000),
                            child: Image.file(
                              widget.indexImage,
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: GridView.builder(
                            shrinkWrap: true,
                            controller: provider.faceScrollController,
                            itemCount: provider.faceDetailFileList.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1,
                              mainAxisSpacing: 5,
                              crossAxisSpacing: 5,
                            ),
                            itemBuilder:
                                (BuildContext context, int mediaIndex) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CommonMediasScreen(
                                        files: provider.faceDetailFileList,
                                        initialIndex: mediaIndex,
                                      ),
                                    ),
                                  );
                                },
                                child: Image.file(
                                  provider.faceDetailFileList[mediaIndex],
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  gaplessPlayback: true,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    initial = context.read<AlbumProvider>().initFaceView(value);
    context.read<AlbumProvider>().addFaceScrollListener(value);
  }
}
