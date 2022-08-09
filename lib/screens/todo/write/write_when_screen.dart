import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/widgets/header/header_default_widget.dart';

class WriteWhenScreen extends StatefulWidget {
  const WriteWhenScreen({Key? key}) : super(key: key);

  @override
  State<WriteWhenScreen> createState() => _WriteWhenScreenState();
}

class _WriteWhenScreenState extends State<WriteWhenScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: headerDefaultWidget(
          title: "언제 할래요?",
          leading: FunctionalIcon.back,
          onClickLeading: () {
            Navigator.pop(context);
          }),
    );
  }
}
