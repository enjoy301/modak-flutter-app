import 'package:flutter/material.dart';

class AlbumThemeWidget extends StatefulWidget {
  const AlbumThemeWidget({Key? key}) : super(key: key);

  @override
  State<AlbumThemeWidget> createState() => _AlbumThemeWidgetState();
}

class _AlbumThemeWidgetState extends State<AlbumThemeWidget> {
  @override
  Widget build(BuildContext context) {
    return Text("theme");
  }
}
