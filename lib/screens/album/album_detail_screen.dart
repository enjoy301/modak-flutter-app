import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/widgets/album/album_day_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class AlbumDetailScreen extends StatefulWidget {
  const AlbumDetailScreen({Key? key, required this.type}) : super(key: key);

  final String type;

  @override
  State<AlbumDetailScreen> createState() => _AlbumDetailScreenState();
}

class _AlbumDetailScreenState extends State<AlbumDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "messenger": {
        "title": "일반 메신저 앨범",
        "blankMessage": "아직 사진이 없습니다\n채팅방에 사진을 올려보세요",
        "files": context.watch<AlbumProvider>().messengerAlbumFiles,
      },
      "todo": {
        "title": "집안일 완료 앨범",
        "blankMessage": "아직 사진이 없습니다\n할 일 목록에 사진을 올려보세요",
        "files": context.watch<AlbumProvider>().todoAlbumFiles,
      }
    };
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: headerDefaultWidget(
            title: data[widget.type]['title'],
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Navigator.pop(context);
            }),
        body: data[widget.type]['files'].length > 0
            ? SingleChildScrollView(
          child: Column(
            children: [
              AlbumDayWidget(),
              AlbumDayWidget(),
              AlbumDayWidget(),
              AlbumDayWidget(),
            ],
          ),
        )
            : Padding(
              padding: const EdgeInsets.only(bottom: 200.0),
              child: Center(
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        color: Coloring.gray_50,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        data[widget.type]['blankMessage'],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Coloring.gray_20,
                          fontSize: Font.size_mediumText,
                          fontWeight: Font.weight_semiBold,
                        ),
                      ))),
            ));
  }
}
