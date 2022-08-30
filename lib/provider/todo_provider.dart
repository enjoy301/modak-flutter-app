import 'package:flutter/material.dart';
import 'package:modak_flutter_app/data/model/todo_model.dart';

class TodoProvider extends ChangeNotifier {

  final List<TodoModel> _todos = [];
  DateTime _focusedDateTime = DateTime.now();
  int _todoCount = 40;

  List<TodoModel> get todos => _todos;
  DateTime get focusedDateTime => _focusedDateTime;
  int get todoCount => _todoCount;


  void add(TodoModel todo) {
    _todos.add(todo);
    notifyListeners();
  }
  TodoModel getTodoAt(int index) {
    return _todos[index];
  }

  setFocusedDatetime(DateTime focusedDateTime) {
    _focusedDateTime = focusedDateTime;
  }

  setTodoCount(int todoCount) {
    _todoCount = todoCount;
    notifyListeners();
  }
  todoCountIncrement() {
    _todoCount ++;
    notifyListeners();
  }
  todoCountDecrement() {
    _todoCount --;
    notifyListeners();
  }
}