import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:provider/provider.dart';
import 'package:modak_flutter_app/utils/media_util.dart';

class AlbumDayWidget extends StatefulWidget {
  const AlbumDayWidget({Key? key}) : super(key: key);

  @override
  State<AlbumDayWidget> createState() => _AlbumDayWidgetState();
}

class _AlbumDayWidgetState extends State<AlbumDayWidget> {
  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    List<File> fileList = context.read<AlbumProvider>().messengerAlbumFiles;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IgnorePointer(
          child: Consumer<AlbumProvider>(
            builder: (context, provider, child) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                controller: scrollController,
                itemCount: provider.messengerAlbumFiles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin:
                        EdgeInsets.only(top: 9, right: 10, bottom: 8, left: 10),
                    child: Column(
                      children: [
                        index == 0 ||
                                fileList[index]
                                        .path
                                        .split('/')
                                        .last
                                        .split('d')[0] !=
                                    fileList[index - 1]
                                        .path
                                        .split('/')
                                        .last
                                        .split('d')[0]
                            ? Text(fileList[index]
                                .path
                                .split('/')
                                .last
                                .split('d')[0])
                            : SizedBox.shrink(),
                        fileList[index].path.endsWith(".mp4")
                            ? FutureBuilder(
                                future: getVideoThumbnail(fileList[index]),
                                initialData: File(""),
                                builder: (BuildContext context,
                                    AsyncSnapshot<File> file) {
                                  return file.data!.uri.toString() == ''
                                      ? Image.asset(
                                          "lib/assets/images/others/empty_messenger_album.png")
                                      : Image.file(
                                          file.data!,
                                          fit: BoxFit.cover,
                                        );
                                },
                              )
                            : Image.file(fileList[index], fit: BoxFit.cover),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
