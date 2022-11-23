import 'dart:async';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:modak_flutter_app/utils/media_util.dart';
import 'package:video_player/video_player.dart';

class CommonMediasScreen extends StatefulWidget {
  const CommonMediasScreen(
      {Key? key, required this.files, this.initialIndex = 0})
      : super(key: key);

  final List<File> files;
  final int initialIndex;

  @override
  State<CommonMediasScreen> createState() => _CommonMediasScreenState();
}

class _CommonMediasScreenState extends State<CommonMediasScreen> {
  bool showHeaderAndFooter = true;
  int imageIndex = 0;
  final List<File> filesWithThumbnail = [];
  late PageController pageController =
      PageController(initialPage: widget.initialIndex);

  @override
  void initState() {
    super.initState();
    if (widget.files.length > 1) addFiles();
    imageIndex = widget.initialIndex;
  }

  addFiles() async {
    for (File file in widget.files) {
      if (file.path.toLowerCase().endsWith("mp4") ||
          file.path.toLowerCase().endsWith("mov")) {
        filesWithThumbnail.add(await getVideoThumbnailFile(file));
      } else {
        filesWithThumbnail.add(file);
      }
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.black,
      appBar: showHeaderAndFooter
          ? AppBar(
              backgroundColor: Colors.black.withOpacity(0.5),
              actions: [
                IconButton(
                  onPressed: () {
                    downloadToGallery(widget.files[imageIndex]);
                  },
                  icon: Icon(Icons.download),
                )
              ],
              elevation: 0,
            )
          : null,
      body: GestureDetector(
        onTap: () {
          setState(() {
            showHeaderAndFooter = !showHeaderAndFooter;
          });
        },
        child: Container(
          color: Colors.black,
          child: Stack(
            children: [
              PageView(
                controller: pageController,
                onPageChanged: (index) => setState(
                  () {
                    imageIndex = index;
                  },
                ),
                children: widget.files
                    .mapIndexed(
                      (index, file) => Center(
                        child: file.path.toLowerCase().endsWith("mp4") ||
                                file.path.toLowerCase().endsWith("mov")
                            ? CommonVideoScreen(
                                file: file,
                              )
                            : CommonImageScreen(file: file),
                      ),
                    )
                    .toList(),
              ),
              if (widget.files.length > 1)
                Positioned(
                  bottom: 0,
                  child: Opacity(
                    opacity: showHeaderAndFooter ? 1 : 0,
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black.withOpacity(0.5),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Center(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: filesWithThumbnail
                                  .mapIndexed(
                                    (index, file) => GestureDetector(
                                      onTap: () {
                                        pageController.jumpToPage(index);
                                        setState(
                                          () {
                                            imageIndex = index;
                                          },
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 3,
                                        ),
                                        child: Stack(
                                          children: [
                                            Center(
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  3,
                                                ),
                                                child: Image.file(
                                                  file,
                                                  width: 50,
                                                  height: 80,
                                                  fit: BoxFit.cover,
                                                  gaplessPlayback: true,
                                                ),
                                              ),
                                            ),
                                            if (index == imageIndex)
                                              Center(
                                                child: Container(
                                                  width: 50,
                                                  height: 80,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      3,
                                                    ),
                                                    border: Border.all(
                                                      color: Colors.white,
                                                      width: 3,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

class CommonImageScreen extends StatefulWidget {
  const CommonImageScreen({Key? key, required this.file}) : super(key: key);

  final File file;
  @override
  State<CommonImageScreen> createState() => _CommonImageScreenState();
}

class _CommonImageScreenState extends State<CommonImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height,
        maxWidth: MediaQuery.of(context).size.width,
      ),
      child: Image.file(
        widget.file,
        width: double.infinity,
        fit: BoxFit.contain,
      ),
    );
  }
}

class CommonVideoScreen extends StatefulWidget {
  const CommonVideoScreen({Key? key, required this.file}) : super(key: key);
  final File file;
  @override
  State<CommonVideoScreen> createState() => _CommonVideoScreenState();
}

class _CommonVideoScreenState extends State<CommonVideoScreen> {
  Timer? _timer;
  bool isIconVisible = true;
  late final VideoPlayerController _controller = VideoPlayerController.file(
    widget.file,
  );
  late final Future<void> _initializeVideoPlayerFuture =
      _controller.initialize().then(
            (value) => {
              _controller.addListener(
                () {
                  setState(
                    () {
                      if (!_controller.value.isPlaying &&
                          _controller.value.isInitialized &&
                          (_controller.value.duration ==
                              _controller.value.position)) {
                        setState(
                          () {
                            _controller.pause();
                          },
                        );
                      }
                    },
                  );
                },
              )
            },
          );

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              _timer?.cancel();
              isIconVisible = true;
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                FutureBuilder(
                  future: _initializeVideoPlayerFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Center(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 7 / 10,
                          ),
                          child: FittedBox(
                            fit: BoxFit.fitWidth,
                            child: SizedBox(
                              width: _controller.value.size.width,
                              height: _controller.value.size.height,
                              child: VideoPlayer(_controller),
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                Transform.scale(
                  scale: 3,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        isIconVisible = true;
                        _timer?.cancel();
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                          _timer = Timer(Duration(seconds: 3), () {
                            setState(() {
                              isIconVisible = false;
                            });
                          });
                        }
                      });
                    },
                    icon: Visibility(
                      visible: isIconVisible,
                      child: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
            ),
          ),
        ],
      ),
    );
  }
}

void downloadToGallery(File file) async {
  final result = await ImageGallerySaver.saveFile(file.path);
  if (result['isSuccess']) {
    Fluttertoast.showToast(msg: "다운로드 되었습니다", toastLength: Toast.LENGTH_SHORT);
  }
}
