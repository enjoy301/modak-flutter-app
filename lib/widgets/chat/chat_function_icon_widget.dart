import 'package:flutter/material.dart';

class ChatFunctionIconWidget extends StatelessWidget {
  const ChatFunctionIconWidget(
      {Key? key, required this.data, required this.onTap})
      : super(key: key);
  final Map<String, dynamic> data;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
                decoration: BoxDecoration(
                    color: data['color'],
                    borderRadius: BorderRadius.circular(100)),
                child: Text("뭐야 씨발")),
          ),
          Text(data['name'], style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
