import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modak_flutter_app/constant/coloring.dart';
import 'package:modak_flutter_app/constant/font.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/notification.dart';
import 'package:modak_flutter_app/utils/easy_style.dart';
import 'package:modak_flutter_app/widgets/common/scalable_text_widget.dart';
import 'package:modak_flutter_app/widgets/notification/notification_todo_widget.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({
    Key? key,
    required this.notification,
  }) : super(key: key);

  final Noti notification;

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  late final Map<String, Widget> typeMapper;

  @override
  void initState() {
    typeMapper = {
      Strings.notiTodo: NotificationTodoWidget(
        notification: widget.notification,
      )
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: UniqueKey(),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(width: 1, color: Coloring.gray_10),
          ),
        ),
        child: ListTile(
          title: ScalableTextWidget(widget.notification.title.trim(),
              style: EasyStyle.text(
                  Coloring.gray_0, Font.size_mediumText, Font.weight_medium)),
          subtitle: ScalableTextWidget(
            widget.notification.des.trim(),
            style: EasyStyle.text(
                Coloring.gray_0, Font.size_smallText, Font.weight_regular),
          ),
          tileColor:
              widget.notification.isRead ? Colors.white : Coloring.bg_blue,
        ),
      ),
    );
  }
}
