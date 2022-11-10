import 'package:flutter/material.dart';
import 'package:modak_flutter_app/widgets/album/album_day_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

import '../../provider/album_provider.dart';
import '../../widgets/album/album_face_widget.dart';
import '../../widgets/album/album_theme_widget.dart';

class AlbumLandingScreen extends StatefulWidget {
  const AlbumLandingScreen({Key? key}) : super(key: key);

  @override
  State<AlbumLandingScreen> createState() => _AlbumLandingScreenState();
}

class _AlbumLandingScreenState extends State<AlbumLandingScreen> {
  late Future init;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: headerDefaultWidget(
          title: "앨범",
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabs: [Tab(child: Text("전체")), Tab(child: Text("인물")), Tab(child: Text("테마"))],
                isScrollable: true,
                indicator: UnderlineTabIndicator(
                  insets: EdgeInsets.only(bottom: 10),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                labelPadding: EdgeInsets.symmetric(horizontal: 20),
                labelColor: Colors.blueAccent,
                unselectedLabelColor: Colors.black,
                indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: init,
            builder: (context, snapshot) {
              return TabBarView(
                children: [
                  AlbumDayWidget(),
                  AlbumFaceWidget(),
                  AlbumThemeWidget(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    init = context.read<AlbumProvider>().initTotalData();
  }
}
