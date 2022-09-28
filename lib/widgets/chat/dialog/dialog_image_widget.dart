import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/data/model/chat.dart';

class DialogImageWidget extends StatefulWidget {
  const DialogImageWidget({Key? key, required this.chat}) : super(key: key);

  final Chat chat;

  @override
  State<DialogImageWidget> createState() => _DialogImageWidgetState();
}

class _DialogImageWidgetState extends State<DialogImageWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 2 / 3,
      height: MediaQuery.of(context).size.width * 2 / 3 * 25 / 16,
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          Image.asset(
            "lib/assets/images/family/dad.png",
            width: MediaQuery.of(context).size.width * 2 / 3,
            height: MediaQuery.of(context).size.width * 2 / 3 * 25 / 16,
          ),
          Positioned(
            right: 7,
            bottom: 5,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Text(
                "+20",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Font.size_smallText,
                  fontWeight: Font.weight_semiBold,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
