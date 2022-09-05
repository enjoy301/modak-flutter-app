import 'package:flutter/material.dart';
import 'package:modak_flutter_app/data/model/todo.dart';

class TodoProvider extends ChangeNotifier {

  final List<Todo> _todos = [];
  DateTime _focusedDateTime = DateTime.now();
  int _todoCount = 40;

  List<Todo> get todos => _todos;
  DateTime get focusedDateTime => _focusedDateTime;
  int get todoCount => _todoCount;


  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }
  Todo getTodoAt(int index) {
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