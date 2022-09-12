import 'dart:io';

import 'package:flutter/material.dart';

class CommonImageScreen extends StatefulWidget {
  const CommonImageScreen({Key? key, required this.file}) : super(key: key);

  final File file;
  @override
  State<CommonImageScreen> createState() => _CommonImageScreenState();
}

class _CommonImageScreenState extends State<CommonImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 50),
        child: Center(
          child: Image.file(
            widget.file,
            width: double.infinity,
            height: 600,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
