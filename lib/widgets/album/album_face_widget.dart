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
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 1,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
            ),
            itemBuilder: (BuildContext context, int mediaIndex) {
              return Text("wow");
            },
          ),
        );
      },
    );
  }
}
