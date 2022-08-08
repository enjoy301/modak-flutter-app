import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/services/album_service.dart';
import 'package:modak_flutter_app/widgets/album/album_container_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class AlbumLandingScreen extends StatefulWidget {
  const AlbumLandingScreen({Key? key}) : super(key: key);

  @override
  State<AlbumLandingScreen> createState() => _AlbumLandingScreenState();
}

class _AlbumLandingScreenState extends State<AlbumLandingScreen> {
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
  @override
  void initState() {
    getMedia();
    super.initState();
  }
  getMedia() async {

    Map<String, dynamic> result = await mediaLoading();
    print(result['response']);

    for (File file in result['response']) {
      print(file.existsSync());
      context.read<AlbumProvider>().addFileToMessengerAlbum(file);
    }
  }
}
