import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../../provider/chat_provider.dart';

class MediaWidget extends StatefulWidget {
  const MediaWidget({
    Key? key,
    required this.file,
    this.width,
    this.height,
    this.radius = 0,
    this.isIconShown = true,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

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
  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: widget.file.path.toLowerCase().endsWith("mp4") || widget.file.path.toLowerCase().endsWith("mov")
                  // ? Text("${path.basename(widget.file.path)}")
                  ? Image.file(
                      provider.thumbnailFiles[path.basename(widget.file.path)]!,
                      fit: widget.boxFit,
                      width: widget.width,
                      height: widget.height,
                      gaplessPlayback: true,
                    )
                  : Image.file(
                      widget.file,
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
                ),
              ),
          ],
        );
      },
    );
  }
}
