import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';
import 'package:modak_flutter_app/data/repository/todo_repository.dart';

class TodoProvider extends ChangeNotifier {
  DateFormat formatter = DateFormat("yyyy-MM-dd");

  init() async {
    _todoRepository = TodoRepository();
    await getTodosByScroll(
      DateTime.now().subtract(
        Duration(
          days: DateTime.now().weekday == 7 ? 0 : DateTime.now().weekday,
        ),
      ),
    );
  }

  static late final TodoRepository _todoRepository;

  final Map<String, List<String>> _colorMap = {};

  final Map<String, List<Todo>> _todoMap = {};
  DateTime todoSavedFromDate = DateUtils.dateOnly(DateTime.now());
  DateTime todoSavedToDate = DateUtils.dateOnly(DateTime.now());
  DateTime _focusedDateTime = DateTime.now();
  DateTime _selectedDateTime = DateTime.now();
  int todoCount = 0;

  Map<String, List<String>> get colorMap => _colorMap;

  Map<String, List<Todo>> get todoMap => _todoMap;

  DateTime get focusedDateTime => _focusedDateTime;

  DateTime get selectedDateTime => _selectedDateTime;

  set focusedDateTime(DateTime focusedDateTime) {
    _focusedDateTime = focusedDateTime;
    notifyListeners();
  }

  set selectedDateTime(DateTime selectedDateTime) {
    _selectedDateTime = selectedDateTime;
    notifyListeners();
  }

  Future<bool> getTodosByScroll(DateTime date) async {
    DateTime fromDate = DateUtils.dateOnly(date);
    DateTime toDate = DateUtils.dateOnly(date).add(Duration(days: 6));
    if (!fromDate.isBefore(todoSavedFromDate) &&
        !toDate.isAfter(todoSavedToDate)) {
      return true;
    }

    Map<String, dynamic> response = await _todoRepository.getTodos(
        formatter.format(fromDate), formatter.format(toDate));

    switch (response[Strings.message]) {
      case Strings.success:
        syncTodos(
            Map<String, List<dynamic>>.from(
                response[Strings.response]["color"]),
            Map<String, List<dynamic>>.from(
                response[Strings.response]["items"]));

        Fluttertoast.showToast(msg: "할 일 성공적으로 가져옴");
        todoSavedFromDate =
            fromDate.isBefore(todoSavedFromDate) ? fromDate : todoSavedFromDate;
        todoSavedToDate =
            toDate.isAfter(todoSavedToDate) ? toDate : todoSavedToDate;
        return true;
      case Strings.fail:
        Fluttertoast.showToast(msg: "할 일 가져오기 실패");
        return false;
    }
    return false;
  }

  Future<bool> postTodo(Todo todo) async {
    String fromDate = todo.date;
    String toDate = todo.date;
    if (todo.repeat!.contains(1)) {
      fromDate = formatter.format(todoSavedFromDate);
      toDate = formatter.format(todoSavedToDate);
    }
    Map<String, dynamic> response =
        await _todoRepository.postTodo(todo, fromDate, toDate);
    switch (response[Strings.message]) {
      case Strings.success:
        Fluttertoast.showToast(msg: "성공적으로 추가");
        syncTodos(
            Map<String, List<dynamic>>.from(
                response[Strings.response]["color"]),
            Map<String, List<dynamic>>.from(
                response[Strings.response]["items"]));
        return true;
      case Strings.fail:
        Fluttertoast.showToast(msg: "할 일 등록 실패");
        return false;
      case Strings.noValue:
        Fluttertoast.showToast(msg: "입력하지 않은 값이 있습니다");
        return false;
    }
    return false;
  }

  Future<bool> doneTodo(Todo todo, bool isDone) async {
    Map<String, dynamic> response = await _todoRepository.doneTodo(todo, isDone,
        formatter.format(todoSavedFromDate), formatter.format(todoSavedToDate));
    switch (response[Strings.message]) {
      case Strings.success:
        Fluttertoast.showToast(msg: "성공적으로 추가");
        syncTodos(
            Map<String, List<dynamic>>.from(
                response[Strings.response]["color"]),
            Map<String, List<dynamic>>.from(
                response[Strings.response]["items"]));
        return true;
      case Strings.fail:
        Fluttertoast.showToast(msg: "할 일 등록 실패");
        return false;
    }
    return false;
  }

  Future<bool> updateTodo(Todo todo, bool isAfterUpdate) async {
    todo.title = todo.title.trim();
    todo.memo = todo.memo?.trim();
    Map<String, dynamic> response = await _todoRepository.updateTodo(
        todo,
        isAfterUpdate,
        formatter.format(todoSavedFromDate),
        formatter.format(todoSavedToDate));
    switch (response[Strings.message]) {
      case Strings.success:
        Fluttertoast.showToast(msg: "성공적으로 추가");
        syncTodos(
            Map<String, List<dynamic>>.from(
                response[Strings.response]["color"]),
            Map<String, List<dynamic>>.from(
                response[Strings.response]["items"]));
        return true;
      case Strings.fail:
        Fluttertoast.showToast(msg: "할 일 등록 실패");
        return false;
    }
    return false;
  }

  Future<bool> deleteTodo(Todo todo, bool isAfterUpdate) async {
    Map<String, dynamic> response = await _todoRepository.deleteTodo(
        todo,
        isAfterUpdate,
        formatter.format(todoSavedFromDate),
        formatter.format(todoSavedToDate));

    switch (response[Strings.message]) {
      case Strings.success:
        Fluttertoast.showToast(msg: "삭제 성공");
        syncTodos(
            Map<String, List<dynamic>>.from(
                response[Strings.response]["color"]),
            Map<String, List<dynamic>>.from(
                response[Strings.response]["items"]));
        return true;
      case Strings.fail:
        Fluttertoast.showToast(msg: "삭제 실패");
        return false;
    }
    return false;
  }

  syncTodos(Map<String, List<dynamic>> colorResponse,
      Map<String, List<dynamic>> itemsResponse) {
    for (String key in colorResponse.keys) {
      _colorMap[key] = List<String>.from(colorResponse[key]!);
    }
    for (String key in itemsResponse.keys) {
      List<Todo> todos = [];
      for (Map<String, dynamic> item in itemsResponse[key]!) {
        todos.add(
          Todo(
              todoId: item[Strings.todoId],
              groupTodoId: item[Strings.groupTodoId],
              memberId: item[Strings.memberId],
              title: item[Strings.title],
              color: item[Strings.color],
              isDone: item[Strings.isDone] == 1 ? true : false,
              timeTag: item[Strings.timeTag],
              repeatTag: item[Strings.repeatTag],
              repeat: null,
              memo: item[Strings.memo],
              date: key),
        );
      }
      _todoMap[key] = todos;
    }

    notifyListeners();
  }
}
