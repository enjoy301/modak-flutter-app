import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/notification.dart';
import 'package:modak_flutter_app/widgets/notification/notification_todo_widget.dart';

class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key, required this.notification, required this.onDismiss, required this.onArchive})
      : super(key: key);

  final Noti notification;
  final Function() onDismiss;
  final Function() onArchive;

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
      startActionPane: ActionPane(
        motion: ScrollMotion(),
        dismissible: DismissiblePane(onDismissed: widget.onDismiss),
        children: [
          SlidableAction(
            onPressed: (context) {
              widget.onDismiss.call();
            },
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        children: [
          SlidableAction(
            // An action can be bigger than the others.
            flex: 2,
            onPressed: (BuildContext context) {
              widget.onArchive.call();
            },
            backgroundColor: Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.archive,
            label: 'Archive',
          ),
        ],
      ),
      child: ListTile(
        title: Text(widget.notification.title),
        subtitle: Text(widget.notification.des),
        tileColor: widget.notification.isRead ? Colors.white : Colors.blue,
      ),
    );
  }
}
