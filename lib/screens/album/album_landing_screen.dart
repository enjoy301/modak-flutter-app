import 'package:flutter/material.dart';
import 'package:modak_flutter_app/widgets/album/album_container_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';

class AlbumLandingScreen extends StatelessWidget {
  const AlbumLandingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: headerDefaultWidget(title: "앨범"),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 30),
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: AlbumContainerWidget(
                    type: "messenger",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: AlbumContainerWidget(
                    type: "todo",
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
