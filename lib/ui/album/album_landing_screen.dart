import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
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
        backgroundColor: Coloring.gray_50,
        appBar: headerDefaultWidget(
          title: "앨범",
          leading: FunctionalIcon.none,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabs: [Tab(child: Text("전체 사진 보기")), Tab(child: Text("인물별 모아보기")), Tab(child: Text("테마별 모아보기"))],
                isScrollable: true,
                labelPadding: EdgeInsets.only(left: 10, right: 10),
                labelStyle: TextStyle(color: Colors.black, fontSize: Font.size_h3, fontWeight: Font.weight_bold),
                labelColor: Colors.black,
                unselectedLabelColor: Coloring.gray_20,
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: FutureBuilder(
            future: init,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return TabBarView(
                  children: [
                    AlbumDayWidget(),
                    AlbumFaceWidget(),
                    AlbumThemeWidget(),
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
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
