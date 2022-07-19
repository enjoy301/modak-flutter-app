import 'package:flutter/material.dart';

class ChatFunctionIconWidget extends StatelessWidget {
  const ChatFunctionIconWidget({Key? key, required this.data})
      : super(key: key);
  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
              decoration: BoxDecoration(color: data['color'], borderRadius: BorderRadius.circular(100)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  onPressed: () {},
                  icon: Image.asset(data['image']),
                ),
              )),
        ),
        Text(data['name'], style: TextStyle(color: Colors.black)),
      ],
    );
  }
}
