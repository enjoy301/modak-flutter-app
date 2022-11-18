import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/assets/icons/light/LightIcons_icons.dart';
import 'package:provider/provider.dart';

import '../../provider/album_provider.dart';

class MediaWidgetForAlbum extends StatefulWidget {
  const MediaWidgetForAlbum({
    Key? key,
    required this.file,
    this.width,
    this.height,
    this.radius = 0,
    this.isIconShown = false,
    this.boxFit = BoxFit.cover,
  }) : super(key: key);

  final File file;
  final double? width;
  final double? height;
  final double radius;
  final bool isIconShown;
  final BoxFit boxFit;

  @override
  State<MediaWidgetForAlbum> createState() => _MediaWidgetForAlbum();
}

class _MediaWidgetForAlbum extends State<MediaWidgetForAlbum> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AlbumProvider>(
      builder: (context, provider, child) {
        return Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: widget.file.path.toLowerCase().endsWith("mp4") || widget.file.path.toLowerCase().endsWith("mov")
                  ? Image.file(
                      widget.file,
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
            if (widget.isIconShown)
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
