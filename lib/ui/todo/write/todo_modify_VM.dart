import 'package:flutter/cupertino.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoModifyVM extends ChangeNotifier {
  bool isAfterUpdate = false;

  Todo _todo = Todo(
      todoId: -1,
      groupTodoId: -1,
      memberId: -1,
      title: "",
      color: "",
      isDone: false,
      timeTag: null,
      repeatTag: null,
      repeat: [0, 0, 0, 0, 0, 0, 0],
      memo: "",
      date: "");

  Todo get todo => _todo;
  set todo(Todo todo) {
    _todo = todo;
    notifyListeners();
  }

  User? _manager;
  User? get manager => _manager;
  set manager(User? manager) {
    if (manager != null) _manager = manager;
  }

  Future<bool> updateTodo(BuildContext context) async {
    if (todo.repeatTag == null) {
      todo.repeat = [0, 0, 0, 0, 0, 0, 0];
    } else {
      todo.repeat = [1, 1, 1, 1, 1, 1, 1];
    }
    return await context.read<TodoProvider>().updateTodo(todo, isAfterUpdate);
  }

  notify() {
    notifyListeners();
  }
}
