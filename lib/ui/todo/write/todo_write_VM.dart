import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/data/model/todo.dart';
import 'package:modak_flutter_app/data/model/user.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/provider/todo_provider.dart';
import 'package:provider/provider.dart';

class TodoWriteVM extends ChangeNotifier {
  TodoWriteVM() {
    _init();
  }
  _init() async {
    _userRepository = await UserRepository.create();
    _manager = _userRepository.getMe();
  }

  late final UserRepository _userRepository;

  String _title = "";
  String get title => _title;
  set title(String title) {
    _title = title;
    notifyListeners();
  }

  User? _manager;
  User? get manager => _manager;
  set manager(User? manager) {
    _manager = manager;
    notifyListeners();
  }

  DateTime _date = DateTime.now();
  DateTime get date => _date;
  set date(DateTime date) {
    _date = date;
    notifyListeners();
  }

  String? _timeTag;
  String? get timeTag => _timeTag;
  set timeTag(String? timeTag) {
    _timeTag = timeTag;
    notifyListeners();
  }

  List<int> repeat = [0, 0, 0, 0, 0, 0, 0];
  void toggleRepeat(int index) {
    repeat[index] = repeat[index] == 1 ? 0 : 1;
    notifyListeners();
  }

  String memo = "";

  bool getIsValid() {
    return title.isNotEmpty;
  }

  Future<bool> postTodo(BuildContext context) async {
    return await Future(() => context.read<TodoProvider>().postTodo(Todo(
        todoId: 0,
        groupTodoId: 0,
        memberId: 0,
        title: title,
        color: "null",
        isDone: false,
        timeTag: timeTag,
        repeatTag: "null",
        repeat: repeat,
        memo: memo,
        date: DateFormat("yyyy-MM-dd").format(date))));
  }
}
