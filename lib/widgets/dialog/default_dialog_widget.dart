import 'package:flutter/material.dart';

void DefaultDialogWidget(BuildContext context) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(onPressed: () {Navigator.pop(context);}, child: Text("수정하기")),
              TextButton(onPressed: () {Navigator.pop(context);}, child: Text("삭제하기")),
            ],
          ),
        );
      });
}
