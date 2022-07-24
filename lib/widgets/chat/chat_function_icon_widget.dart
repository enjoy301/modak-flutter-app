import 'package:flutter/material.dart';

class ChatFunctionIconWidget extends StatelessWidget {
  const ChatFunctionIconWidget({Key? key, required this.data, required this.onTap})
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
            padding: const EdgeInsets.all(20.0),
            child: Container(
                decoration: BoxDecoration(
                    color: data['color'],
                    borderRadius: BorderRadius.circular(100)),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Image.asset(data['image']),
                )),
          ),
          // Text(data['name'], style: TextStyle(color: Colors.black)),
        ],
      ),
    );
  }
}
