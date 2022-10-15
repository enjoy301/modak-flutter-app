import 'package:flutter/material.dart';

void modalCheckwidget(BuildContext context,
    {String title = "제목",
    String okText = "확인",
    String noText = "닫기",
    required Function() onOkPressed,
    required Function() onNoPressed}) {
  showDialog(
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          actions: [
            ElevatedButton(onPressed: onOkPressed, child: Text(okText)),
            ElevatedButton(onPressed: onNoPressed, child: Text(noText)),
          ],
        );
      },
      context: context);
}
