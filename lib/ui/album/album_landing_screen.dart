import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/user_provider.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/album/album_day_widget.dart';
import 'package:modak_flutter_app/widgets/button/button_cancel_widget.dart';
import 'package:modak_flutter_app/widgets/button/button_main_widget.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:modak_flutter_app/widgets/input/input_text_widget.dart';
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
          customTrailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(15))),
                  title: Text(
                    "앨범 전체 다운로드",
                    style: EasyStyle.text(
                        Colors.black, Font.size_subTitle, Font.weight_semiBold),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "이메일을 보내주시면 24시간 내로 앨범 사진 전체를 보내드리겠습니다",
                        style: EasyStyle.text(Colors.black, Font.size_smallText,
                            Font.weight_regular),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: InputTextWidget(
                          hint: "이메일 입력",
                          textEditingController: TextEditingController(),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 24),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Expanded(
                                flex: 10,
                                child: ButtonCancelWidget(
                                    title: "취소",
                                    height: 40,
                                    onPressed: () {
                                      Get.back();
                                    })),
                            Expanded(
                              flex: 2,
                              child: SizedBox.shrink(),
                            ),
                            Expanded(
                              flex: 20,
                              child: ButtonMainWidget(
                                title: "완료",
                                height: 40,
                                onPressed: () {
                                  Fluttertoast.showToast(
                                      msg: "이메일이 전송되었습니다\n이메일로 사진을 보내드리겠습니다");
                                  Get.back();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
            icon: Icon(
              LightIcons.Download,
              color: Colors.black,
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(40),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TabBar(
                tabs: [
                  Tab(child: Text("전체 사진 보기")),
                  Tab(child: Text("인물별 모아보기")),
                  Tab(child: Text("테마별 모아보기"))
                ],
                isScrollable: true,
                labelPadding: EdgeInsets.only(left: 10, right: 10),
                labelStyle: TextStyle(
                    color: Colors.black,
                    fontSize: Font.size_h3 *
                        context.read<UserProvider>().getFontScale(),
                    fontWeight: Font.weight_bold),
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
