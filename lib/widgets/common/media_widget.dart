import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/utils/media_util.dart';

class MediaWidget extends StatefulWidget {
  const MediaWidget(
      {Key? key,
      required this.file,
      this.width,
      this.height,
      this.radius = 0,
      this.isIconShown = true,
      this.boxFit = BoxFit.cover})
      : super(key: key);

  final File file;
  final double? width;
  final double? height;
  final double radius;
  final bool isIconShown;
  final BoxFit boxFit;

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  File? file;
  @override
  void initState() {
    getThumbnail();
    super.initState();
  }

  getThumbnail() async {
    if (widget.file.path.mediaType() == "mp4") {
      file = await getVideoThumbnailFile(widget.file);
    } else {
      file = widget.file;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(widget.radius),
          child: file == null
              ? Container(
                  color: Colors.white,
                  width: widget.width,
                  height: widget.height,
                )
              : Image.file(
                  file!,
                  fit: widget.boxFit,
                  width: widget.width,
                  height: widget.height,
                  gaplessPlayback: true,
                ),
        ),
        if (widget.file.isVideo() && widget.isIconShown)
          Positioned.fill(
              child: Icon(
            LightIcons.Play,
            size: 48,
          )),
      ],
    );
  }
}
