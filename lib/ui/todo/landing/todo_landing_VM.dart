import 'package:flutter/material.dart';
import 'package:modak_flutter_app/data/repository/todo_repository.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoLandingVM extends ChangeNotifier {
  TodoLandingVM() {
    init();
  }

  init() async {
    _todoRepository = TodoRepository();
  }

  static late final TodoRepository _todoRepository;

  getTodosByScroll(DateTime dateTime, BuildContext context) {
    context.read<TodoProvider>().getTodosByScroll(dateTime);
  }
}
