import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:provider/provider.dart';

AppBar headerBackWidget(BuildContext context) {
  return AppBar(
    leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => {
              context.read<ChatProvider>().setIsFunctionOpened(false),
              context.read<ChatProvider>().refresh(),
              Navigator.of(context).pop()
            }),
    centerTitle: true,
    title: Text(
      "우리가족 채팅방",
      style: TextStyle(fontSize: 17, color: Colors.black87),
    ),
    backgroundColor: Colors.white,
  );
}
