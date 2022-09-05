import 'package:flutter/material.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoLandingList extends StatefulWidget {
  const TodoLandingList({Key? key}) : super(key: key);

  @override
  State<TodoLandingList> createState() => _TodoLandingListState();
}

class _TodoLandingListState extends State<TodoLandingList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, provider, _) {
        return Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: provider.todos.length,
            itemBuilder: (context, index) {
              return Text("임시");
            },
          ),
        );
      }
    );
  }
}
