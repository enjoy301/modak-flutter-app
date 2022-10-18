import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/ui/common/common_medias_screen.dart';
import 'package:modak_flutter_app/widgets/chat/components/component_info_widget.dart';
import 'package:path_provider/path_provider.dart';

class DialogImageWidget extends StatefulWidget {
  const DialogImageWidget({Key? key, required this.chat, required this.isMine})
      : super(key: key);

  final Chat chat;
  final bool isMine;

  @override
  State<DialogImageWidget> createState() => _DialogImageWidgetState();
}

class _DialogImageWidgetState extends State<DialogImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      textDirection: widget.isMine ? TextDirection.rtl : TextDirection.ltr,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width * 1 / 3,
            maxWidth: MediaQuery.of(context).size.width * 4 / 7,
            maxHeight: MediaQuery.of(context).size.width * 2 / 3,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Stack(
            children: [
              FutureBuilder(
                future: _fetch1(),
                initialData: "",
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data == [""]) {
                    return Image.asset(
                      "lib/assets/images/others/empty_messenger_album.png",
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        Get.to(
                          CommonMediasScreen(
                            files: snapshot.data,
                          ),
                        );
                      },
                      child: Image.file(
                        snapshot.data[0],
                        fit: BoxFit.cover,
                        height: double.infinity,
                        width: double.infinity,
                      ),
                    );
                  }
                },
              ),
              Positioned(
                right: 7,
                bottom: 5,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    widget.chat.metaData!['count'],
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: Font.size_smallText,
                      fontWeight: Font.weight_semiBold,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        ChatComponentInfoWidget(chat: widget.chat),
      ],
    );
  }

  Future<List<dynamic>> _fetch1() async {
    Directory? directory = await getExternalStorageDirectory();

    List<File> fileList = [];
    for (String key in widget.chat.metaData!['key']) {
      fileList.add(
        File(
          "${directory?.path}/Download/cached_media/messengers/$key",
        ),
      );
    }

    if (fileList.isNotEmpty) {
      return fileList;
    } else {
      return [""];
    }
  }
}
