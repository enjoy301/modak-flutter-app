import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/ui/common/common_medias_screen.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

class AlbumDayWidget extends StatefulWidget {
  const AlbumDayWidget({Key? key}) : super(key: key);

  @override
  State<AlbumDayWidget> createState() => _AlbumDayWidgetState();
}

class _AlbumDayWidgetState extends State<AlbumDayWidget> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Consumer<AlbumProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: EdgeInsets.all(5),
          child: RefreshIndicator(
            onRefresh: provider.initTotalData,
            child: ListView.builder(
              controller: provider.scrollController,
              itemCount: provider.albumBuildFileList.length,
              itemBuilder: (BuildContext context, int dateIndex) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.all(12),
                      child: Text(
                        "${provider.albumBuildFileList[dateIndex][0].absolute.path.split('/').last.split('T')[0]}",
                        textAlign: TextAlign.left,
                      ),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      controller: scrollController,
                      itemCount: provider.albumBuildFileList[dateIndex].length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        childAspectRatio: 1,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                      ),
                      itemBuilder: (BuildContext context, int mediaIndex) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommonMediasScreen(
                                  files: [provider.albumBuildFileList[dateIndex][mediaIndex]],
                                ),
                              ),
                            );
                          },
                          onLongPress: () {
                            log("wwowowowoow");
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(
                              1,
                            ),
                            child: (() {
                              if (provider.albumBuildFileList[dateIndex][mediaIndex].path.endsWith(".mp4")) {
                                return Image.file(
                                  provider.thumbnailList[
                                      path.basename(provider.albumBuildFileList[dateIndex][mediaIndex].path)],
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  gaplessPlayback: true,
                                );
                              } else {
                                return Image.file(
                                  provider.albumBuildFileList[dateIndex][mediaIndex],
                                  fit: BoxFit.cover,
                                  height: double.infinity,
                                  width: double.infinity,
                                  gaplessPlayback: true,
                                );
                              }
                            })(),
                          ),
                        );
                      },
                    ),
                  ],
                );
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

    context.read<AlbumProvider>().addScrollListener();
  }
}
