import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/album_provider.dart';
import 'package:modak_flutter_app/ui/common/common_medias_screen.dart';
import 'package:provider/provider.dart';

class AlbumDayWidget extends StatefulWidget {
  const AlbumDayWidget({Key? key}) : super(key: key);

  @override
  State<AlbumDayWidget> createState() => _AlbumDayWidgetState();
}

class _AlbumDayWidgetState extends State<AlbumDayWidget> {
  late Future initial;

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();

    return Consumer<AlbumProvider>(
      builder: (context, provider, child) {
        return FutureBuilder(
          future: initial,
          builder: (context, AsyncSnapshot snapshot) {
            return snapshot.connectionState == ConnectionState.waiting
                ? SizedBox.shrink()
                : Container(
                    margin: EdgeInsets.all(5),
                    child: ListView.builder(
                      itemCount: provider.albumBuildFileList.length,
                      itemBuilder: (BuildContext context, int dateIndex) {
                        return GridView.builder(
                          shrinkWrap: true,
                          controller: scrollController,
                          itemCount:
                              provider.albumBuildFileList[dateIndex].length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 1,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5,
                          ),
                          itemBuilder: (BuildContext context, int mediaIndex) {
                            return provider
                                    .albumBuildFileList[dateIndex][mediaIndex]
                                    .path
                                    .endsWith(".mp4")
                                ? SizedBox.shrink()
                                : GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              CommonMediasScreen(
                                            files: [
                                              provider.albumBuildFileList[
                                                  dateIndex][mediaIndex]
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(5),
                                      child: Image.file(
                                        provider.albumBuildFileList[dateIndex]
                                            [mediaIndex],
                                        fit: BoxFit.cover,
                                        height: double.infinity,
                                        width: double.infinity,
                                      ),
                                    ),
                                  );
                          },
                        );
                      },
                    ),
                  );
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    initial = context.read<AlbumProvider>().initialMediaLoading();
  }
}
