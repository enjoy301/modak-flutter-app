import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/chat_enum.dart';
import 'package:modak_flutter_app/provider/chat_provider.dart';
import 'package:provider/provider.dart';

class InputFunctionWidget extends StatefulWidget {
  const InputFunctionWidget({Key? key}) : super(key: key);

  @override
  State<InputFunctionWidget> createState() => _InputFunctionWidgetState();
}

class _InputFunctionWidgetState extends State<InputFunctionWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              context.read<ChatProvider>().setFunctionState(FunctionState.landing);
            },
            icon: Icon(Icons.cancel_sharp)),
        Expanded(child: Container(color: Colors.yellowAccent,)),
      ],
    );
  }
}
