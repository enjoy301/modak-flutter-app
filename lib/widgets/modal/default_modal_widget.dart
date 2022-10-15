import 'package:flutter/material.dart';

void defaultModalWidget(BuildContext context, List<TextButton> buttons) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: buttons,
          ),
        );
      });
}
