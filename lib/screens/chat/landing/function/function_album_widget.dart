import 'package:flutter/material.dart';

class FunctionAlbumWidget extends StatefulWidget {
  const FunctionAlbumWidget({Key? key}) : super(key: key);

  @override
  State<FunctionAlbumWidget> createState() => _FunctionAlbumWidgetState();
}

class _FunctionAlbumWidgetState extends State<FunctionAlbumWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("안녕"),
    );
  }
}
