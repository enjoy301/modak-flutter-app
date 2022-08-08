import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';

class HomeTodoWidget extends StatefulWidget {
  const HomeTodoWidget({Key? key, required this.title, this.isNone = false})
      : super(key: key);

  final String title;
  final bool isNone;

  @override
  State<HomeTodoWidget> createState() => _HomeTodoWidgetState();
}

class _HomeTodoWidgetState extends State<HomeTodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 30,
        bottom: 16,
        left: 30,
      ),
      child: Material(
        borderRadius: BorderRadius.circular(16),
        elevation: 10,
        child: Container(
          padding: EdgeInsets.all(15),
          child: Row(
            children: [
              Image.asset(
                widget.isNone
                    ? "lib/assets/images/others/home_todo_inactive.png"
                    : "lib/assets/images/others/home_todo_active.png",
                width: 50,
                height: 50,
              ),
              Expanded(
                child: SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      widget.isNone ? "오늘 할 일이 없습니다." : widget.title,
                      style: TextStyle(
                        color: widget.isNone ? Coloring.gray_10 : Colors.black,
                        fontSize: Font.size_mediumText,
                        fontWeight: Font.weight_medium,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ),
              ),
              widget.isNone ?
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 9,),
                  decoration: BoxDecoration(
                    gradient: Coloring.main,
                    borderRadius: BorderRadius.circular(99),
                  ),
                child: Text("등록", style: TextStyle(
                  color: Colors.white,
                  fontSize: Font.size_smallText,
                  fontWeight: Font.weight_semiBold,
                )),
              ):
                  Text(""),
            ],
          ),
        ),
      ),
    );
  }
}
