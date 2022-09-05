import 'package:flutter/material.dart';
import 'package:modak_flutter_app/data/repository/todo_repository.dart';

class TodoLandingVM extends ChangeNotifier {
  TodoLandingVM() {
    init();
  }

  init() async {
    _todoRepository = await TodoRepository.create();
  }

  late final TodoRepository _todoRepository;

  getTodos() async {
    String string = await _todoRepository.getTodos();
  }
}