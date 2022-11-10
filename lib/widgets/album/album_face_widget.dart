import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:provider/provider.dart';

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
          margin: EdgeInsets.all(5),
          child: GridView.builder(
            shrinkWrap: true,
            itemCount: provider.faceDataList.length,
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
                        print("wow");
                      },
                      child: Image.file(
                        provider.faceFileList[faceIndex],
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
                          "${provider.faceDataList[faceIndex]['count']}",
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
