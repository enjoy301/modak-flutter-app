import 'package:flutter/material.dart';

class ChatFunctionIconWidget extends StatelessWidget {
  const ChatFunctionIconWidget(
      {Key? key, required this.data, required this.onTap})
      : super(key: key);
  final Map<String, dynamic> data;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: data['color'],
                    borderRadius: BorderRadius.circular(100)),
                child: Icon(data['icon'])),
          ),
        ),
        Text(data['name'], style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
