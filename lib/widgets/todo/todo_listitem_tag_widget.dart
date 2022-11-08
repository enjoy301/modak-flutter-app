import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';

class TodoListItemTagWidget extends StatelessWidget {
  const TodoListItemTagWidget({Key? key, required this.name}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
        decoration: BoxDecoration(
          border: Border.all(
            color: Coloring.gray_20,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 2),
          child: Text(name,
              style: TextStyle(
                  color: Coloring.gray_10, fontSize: Font.size_caption, fontWeight: Font.weight_regular, height: 1)),
        ),
      ),
    );
  }
}
