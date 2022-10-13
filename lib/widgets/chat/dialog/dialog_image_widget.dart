import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:path_provider/path_provider.dart';

class DialogImageWidget extends StatefulWidget {
  const DialogImageWidget({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<DialogImageWidget> createState() => _DialogImageWidgetState();
}

class _DialogImageWidgetState extends State<DialogImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 2 / 3,
      height: MediaQuery.of(context).size.width * 2 / 3,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          FutureBuilder(
            future: _fetch1(),
            initialData: "",
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              return snapshot.data == ""
                  ? Image.asset(
                      "lib/assets/images/others/empty_messenger_album.png",
                    )
                  : Image.file(
                      File(snapshot.data!),
                      fit: BoxFit.cover,
                    );
            },
          ),
          // Image.file(
          //   File(
          //       "${directory?.path}/Download/cached_media/messengers/${widget.chat.metaData!['key']}"),
          //   width: MediaQuery.of(context).size.width * 2 / 3,
          //   height: MediaQuery.of(context).size.width * 2 / 3 * 25 / 16,
          // ),
          Positioned(
            right: 7,
            bottom: 5,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
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
    );
  }

  Future _fetch1() async {
    Directory? directory = await getExternalStorageDirectory();
    String url =
        "${directory?.path}/Download/cached_media/messengers/${widget.chat.metaData!['key']}";

    if (await File(url).exists()) {
      return url;
      // return Image.file(
      //   file,
      //   fit: BoxFit.cover,
      // );
    } else {
      return "";
    }
  }
}
