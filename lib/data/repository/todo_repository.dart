import 'dart:developer';

import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/dto/todo.dart';

/// response: returns response which should be updated
/// message: acknowledges result of request

class TodoRepository {
  TodoRepository._privateConstructor() {
    localDataSource = LocalDataSource();
    remoteDataSource = RemoteDataSource();
  }

  factory TodoRepository() {
    return _instance;
  }

  static final TodoRepository _instance = TodoRepository._privateConstructor();
  static late final LocalDataSource localDataSource;
  static late final RemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> getTodos(String fromDate, String toDate) async {
    Map<String, dynamic> response =
        await remoteDataSource.getTodos(fromDate, toDate);
    if (response[Strings.result]) {
      Map<String, dynamic> data = response[Strings.response].data["data"];
      return {
        Strings.response: data,
        Strings.message: Strings.success,
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> postTodo(
      Todo todo, String fromDate, String toDate) async {
    if (todo.title == "" || todo.repeat == null) {
      return {Strings.message: Strings.noValue};
    }
    Map<String, dynamic> response =
        await remoteDataSource.postTodo(todo, fromDate, toDate);
    if (response[Strings.result]) {
      Map<String, dynamic> data = response[Strings.response].data["data"]["updateLists"];
      return {
        Strings.message: Strings.success,
        Strings.response: data,
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> doneTodo(
      Todo todo, bool isDone, String fromDate, String toDate) async {
    Map<String, dynamic> response =
        await remoteDataSource.doneTodo(todo, isDone ? 1 : 0, fromDate, toDate);
    if (response[Strings.result]) {
      Map<String, dynamic> data = response[Strings.response].data["data"]["updateLists"];
      return {
        Strings.message: Strings.success,
        Strings.response: data,
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> updateTodo(
      Todo todo, bool isAfterUpdate, String fromDate, String toDate) async {
    Map<String, dynamic> response = await remoteDataSource.updateTodo(
        todo, isAfterUpdate ? 1 : 0, fromDate, toDate);

    if (response[Strings.result]) {
      Map<String, dynamic> data = response[Strings.response].data["data"];
      return {
        Strings.message: Strings.success,
        Strings.response: data,
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> deleteTodo(
      Todo todo, bool isAfterUpdate, String fromDate, String toDate) async {
    Map<String, dynamic> response = await remoteDataSource.deleteTodo(
        todo, isAfterUpdate ? 1 : 0, fromDate, toDate);
    if (response[Strings.result]) {
      Map<String, dynamic> data = response[Strings.response].data["data"];
      return {
        Strings.message: Strings.success,
        Strings.response: data,
      };
    }
    return {Strings.message: Strings.fail};
  }
}
