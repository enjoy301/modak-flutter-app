import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/dto/chat.dart';
import 'package:modak_flutter_app/ui/common/common_medias_screen.dart';
import 'package:modak_flutter_app/widgets/chat/components/component_info_widget.dart';
import 'package:modak_flutter_app/widgets/common/media_widget.dart';
import 'package:provider/provider.dart';

import '../../../provider/chat_provider.dart';

class DialogImageWidget extends StatefulWidget {
  const DialogImageWidget({Key? key, required this.chat, required this.isMine}) : super(key: key);

  final Chat chat;
  final bool isMine;

  @override
  State<DialogImageWidget> createState() => _DialogImageWidgetState();
}

class _DialogImageWidgetState extends State<DialogImageWidget> {
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
                maxHeight: MediaQuery.of(context).size.width * 5 / 6,
              ),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(
                        CommonMediasScreen(
                          files: provider.getMediaFiles(
                            widget.chat.metaData!['key'],
                          ),
                        ),
                      );
                    },
                    child: MediaWidget(
                      height: double.infinity,
                      width: double.infinity,
                      radius: 15,
                      file: provider.getThumbnail(widget.chat.metaData!['key'][0]),
                      boxFit: BoxFit.cover,
                    ),
                  ),
                  if (int.parse(widget.chat.metaData!['count']) > 1)
                    Positioned(
                      right: 12,
                      bottom: 12,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 6,
                          horizontal: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          widget.chat.metaData!['count'].toString(),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: Font.size_mediumText,
                            fontWeight: Font.weight_semiBold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            ChatComponentInfoWidget(chat: widget.chat),
          ],
        );
      },
    );
  }
}
