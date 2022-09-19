import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/model/todo.dart';

/// response: returns response which should be updated
/// message: acknowledges result of request

class TodoRepository {
  TodoRepository._create();

  static Future<TodoRepository> create() async {
    TodoRepository albumRepository = TodoRepository._create();
    localDataSource ??= await LocalDataSource.create();
    remoteDataSource ??= RemoteDataSource();
    return albumRepository;
  }

  static LocalDataSource? localDataSource;
  static RemoteDataSource? remoteDataSource;

  Future<Map<String, dynamic>> getTodos(String fromDate, String toDate) async {
    Map<String, dynamic> response =
        await remoteDataSource!.getTodos(fromDate, toDate);
    if (response[Strings.result]) {
      return {
        Strings.response: {
          "color": response["response"].data["data"]["color"],
          "items": response["response"].data["data"]["items"],
        },
        Strings.message: Strings.success
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
        await remoteDataSource!.postTodo(todo, fromDate, toDate);
    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "color": response["response"].data["data"]["updateLists"]["color"],
          "items": response["response"].data["data"]["updateLists"]["items"],
        },
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> doneTodo(
      Todo todo, bool isDone, String fromDate, String toDate) async {
    Map<String, dynamic> response = await remoteDataSource!
        .doneTodo(todo, isDone ? 1 : 0, fromDate, toDate);
    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "color": response["response"].data["data"]["updateLists"]["color"],
          "items": response["response"].data["data"]["updateLists"]["items"],
        },
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> updateTodo(
      Todo todo, bool isAfterUpdate, String fromDate, String toDate) async {
    Map<String, dynamic> response = await remoteDataSource!
        .updateTodo(todo, isAfterUpdate ? 1 : 0, fromDate, toDate);
    print(response["response"].data["data"]);
    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "color": response["response"].data["data"]["color"],
          "items": response["response"].data["data"]["items"],
        },
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> deleteTodo(
      Todo todo, bool isAfterUpdate, String fromDate, String toDate) async {
    Map<String, dynamic> response = await remoteDataSource!
        .deleteTodo(todo, isAfterUpdate ? 1 : 0, fromDate, toDate);
    print(response);
    if (response[Strings.result]) {
      return {
        Strings.message: Strings.success,
        Strings.response: {
          "color": response["response"].data["data"]["color"],
          "items": response["response"].data["data"]["items"],
        },
      };
    }
    return {Strings.message: Strings.fail};
  }
}
