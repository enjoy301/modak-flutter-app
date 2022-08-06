import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/screens/album/album_detail_screen.dart';
import 'package:provider/provider.dart';

class AlbumContainerWidget extends StatefulWidget {
  const AlbumContainerWidget({Key? key, required this.type}) : super(key: key);

  final String type;
  @override
  State<AlbumContainerWidget> createState() => _AlbumContainerWidgetState();
}

class _AlbumContainerWidgetState extends State<AlbumContainerWidget> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> data = {
      "messenger": {
        "title": "일반 메신저 앨범",
        "image": "lib/assets/images/others/empty_messenger_album.png",
        "files": context.watch<AlbumProvider>().messengerAlbumFiles,
      },
      "todo": {
        "title": "집안일 완료 앨범",
        "image": "lib/assets/images/others/empty_todo_album.png",
        "files": context.watch<AlbumProvider>().todoAlbumFiles,
      },
    };

    return Consumer<AlbumProvider>(builder: (context, provider, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 16.0, left: 8.0),
            child: Text(
              data[widget.type]['title'],
              style: TextStyle(
                color: Colors.black,
                fontSize: Font.size_largeText,
                fontWeight: Font.weight_semiBold,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => AlbumDetailScreen(
                    type: widget.type,
                  )));
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: AspectRatio(
                aspectRatio: 1.47,
                child: data[widget.type]['files'].length > 0
                    ? Image.file(data[widget.type]['files'][0],
                        width: double.infinity, fit: BoxFit.cover)
                    : Image.asset(data[widget.type]['image'],
                        width: double.infinity, fit: BoxFit.cover),
              ),
            ),
          ),
        ],
      );
    });
  }
}
