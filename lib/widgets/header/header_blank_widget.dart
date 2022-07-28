import 'package:flutter/material.dart';

AppBar headerBlankWidget(String title, Function() onPressed) {
  return AppBar(
    title: Text(
      title,
      style: TextStyle(color: Colors.black),
    ),
    elevation: 0,
    backgroundColor: Colors.white,
    leading: IconButton(
        icon: Icon(
          Icons.keyboard_backspace_outlined,
          color: Colors.black,
        ),
        onPressed: onPressed),
  );
}
