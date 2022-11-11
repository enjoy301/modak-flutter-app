import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:provider/provider.dart';

import '../../ui/common/common_medias_screen.dart';

class AlbumLabelDetailWidget extends StatefulWidget {
  const AlbumLabelDetailWidget({Key? key}) : super(key: key);

  @override
  State<AlbumLabelDetailWidget> createState() => _AlbumLabelDetailWidget();
}

class _AlbumLabelDetailWidget extends State<AlbumLabelDetailWidget> {
  var value = Get.arguments;
  late Future initial;

  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          body: SafeArea(
            child: FutureBuilder(
              future: initial,
              builder: (context, snapshot) {
                return GridView.builder(
                  shrinkWrap: true,
                  controller: provider.labelScrollController,
                  itemCount: provider.labelDetailFileList.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1,
                    mainAxisSpacing: 5,
                    crossAxisSpacing: 5,
                  ),
                  itemBuilder: (BuildContext context, int mediaIndex) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommonMediasScreen(
                              files: [provider.labelDetailFileList[mediaIndex]],
                            ),
                          ),
                        );
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          1,
                        ),
                        child: Image.file(
                          provider.labelDetailFileList[mediaIndex],
                          fit: BoxFit.cover,
                          height: double.infinity,
                          width: double.infinity,
                          gaplessPlayback: true,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    initial = context.read<AlbumProvider>().initLabelView(value);
  }
}
