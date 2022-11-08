import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/home_provider.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';
import 'package:provider/provider.dart';

class HomeTalkWriteScreen extends StatefulWidget {
  const HomeTalkWriteScreen({Key? key}) : super(key: key);

  @override
  State<HomeTalkWriteScreen> createState() => _HomeTalkWriteScreenState();
}

class _HomeTalkWriteScreenState extends State<HomeTalkWriteScreen> {
  bool isInputTappedDown = false;
  String content = "";

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      return Scaffold(
        backgroundColor: Coloring.gray_50,
        appBar: headerDefaultWidget(
            title: "오늘의 한 마디 작성",
            leading: FunctionalIcon.back,
            onClickLeading: () {
              Get.back();
            }),
        body: Padding(
          padding: const EdgeInsets.only(right: 30, bottom: 50, left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                maxLength: 30,
                maxLines: 2,
                decoration: InputDecoration(
                  hintText: "오늘의 한 마디를 적어보세요",
                  border: InputBorder.none,
                ),
                onChanged: (String text) {
                  setState(() {
                    content = text;
                  });
                },
              ),
              Row(
                children: [
                  Expanded(child: SizedBox()),
                  GestureDetector(
                    onTap: () async {
                      if (content.isEmpty) {
                        Fluttertoast.showToast(msg: "값을 입력해주세요");
                      } else {
                        bool isSuccess = await homeProvider.postTodayTalk(context, content);
                        if (isSuccess) Get.back();
                      }
                    },
                    onTapDown: (tapDownDetails) {
                      setState(() {
                        isInputTappedDown = true;
                      });
                    },
                    onTapUp: (tapDownDetails) {
                      setState(() {
                        isInputTappedDown = false;
                      });
                    },
                    onTapCancel: () {
                      setState(() {
                        isInputTappedDown = false;
                      });
                    },
                    child: Text(
                      "오늘의 한 마디 작성",
                      style: TextStyle(
                          color: isInputTappedDown ? Colors.grey[700]!.withOpacity(0.5) : Colors.grey[700],
                          fontSize: Font.size_subTitle,
                          fontWeight: Font.weight_medium,
                          height: 2),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
