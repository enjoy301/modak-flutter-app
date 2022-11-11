import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/widgets/album/album_label_detail_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/album_provider.dart';

class AlbumThemeWidget extends StatefulWidget {
  const AlbumThemeWidget({Key? key}) : super(key: key);

  @override
  State<AlbumThemeWidget> createState() => _AlbumThemeWidgetState();
}

class _AlbumThemeWidgetState extends State<AlbumThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(
      builder: (context, provider, child) {
        return Container(
          margin: EdgeInsets.all(5),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: provider.labelDataList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (BuildContext context, int faceIndex) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(
                  1,
                ),
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Get.to(() => AlbumLabelDetailWidget(), arguments: provider.labelDataList[faceIndex]['label']);
                      },
                      child: Image.file(
                        provider.labelFileList[faceIndex],
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                        gaplessPlayback: true,
                      ),
                    ),
                    Positioned(
                      right: 12,
                      bottom: 12,
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
                          "${provider.labelDataList[faceIndex]['label']}, ${provider.labelDataList[faceIndex]['count']}",
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
