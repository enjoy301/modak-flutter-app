import 'package:flutter/material.dart';

class TodoWriteScreen extends StatelessWidget {
  const TodoWriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("안녕친구들"),
      ),
      body: Center(child: Text("잉")),
    ));
  }
}
