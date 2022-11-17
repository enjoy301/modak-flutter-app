import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:provider/provider.dart';

import 'album_face_detail_widget.dart';

class AlbumFaceWidget extends StatefulWidget {
  const AlbumFaceWidget({Key? key}) : super(key: key);

  @override
  State<AlbumFaceWidget> createState() => _AlbumFaceWidgetState();
}

class _AlbumFaceWidgetState extends State<AlbumFaceWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: EdgeInsets.only(top: 12, right: 30, left: 30),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: provider.faceDataList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (BuildContext context, int faceIndex) {
              return Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        AlbumFaceDetailWidget(
                            indexImage: provider.faceFileList[faceIndex]),
                        arguments: provider.faceDataList[faceIndex]['cid'],
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(1000),
                      child: Image.file(
                        provider.faceFileList[faceIndex],
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        gaplessPlayback: true,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 6,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        "${provider.faceDataList[faceIndex]['count']}",
                        style: EasyStyle.text(Coloring.gray_0,
                            Font.size_smallText, Font.weight_bold),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
