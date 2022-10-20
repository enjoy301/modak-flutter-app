import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/ui/common/common_medias_screen.dart';
import 'package:modak_flutter_app/widgets/chat/components/component_info_widget.dart';
import 'package:provider/provider.dart';

import '../../../provider/chat_provider.dart';

class DialogVideoWidget extends StatefulWidget {
  const DialogVideoWidget({Key? key, required this.chat, required this.isMine})
      : super(key: key);

  final Chat chat;
  final bool isMine;

  @override
  State<DialogVideoWidget> createState() => _DialogVideoWidget();
}

class _DialogVideoWidget extends State<DialogVideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
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
              child: GestureDetector(
                onTap: () {
                  Get.to(
                    CommonMediasScreen(
                      files: provider.getMediaFiles(
                        widget.chat.metaData!['key'],
                      ),
                    ),
                  );
                },
                child: Image.file(
                  provider.chatThumbnailFiles[widget.chat.metaData!['key'][0]]!,
                ),
              ),
            ),
            ChatComponentInfoWidget(chat: widget.chat),
          ],
        );
      },
    );
  }
}
