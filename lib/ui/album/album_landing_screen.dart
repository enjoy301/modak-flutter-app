import 'package:flutter/material.dart';
import 'package:modak_flutter_app/widgets/album/album_day_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';

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
      body: SafeArea(
        child: AlbumDayWidget(),
      ),
    );
  }
}
