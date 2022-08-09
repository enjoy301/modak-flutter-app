import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

/// CREATE
/// todo 생성
Future<Map<String, dynamic>> createTodo() async {
  Dio().post("${dotenv.get("API_ENDPOINT")}/", data: {

  });
  return {};
}

/// READ
/// 주간 todo를 가져오는 서비스
Future<Map<String, dynamic>> getWeekTodos() async {
  Dio().post("path", data: {

  });
  return {};
}

/// UPDATE
/// todo 완료
Future<Map<String, dynamic>> updateTodoDone() async {
  Dio().put("path", data: {

  });
  return {};
}
/// 단일 todo 업데이트
Future<Map<String, dynamic>> updateTodo() async {
  Dio().put("path", data: {

  });
  return {};
}
/// repeat todo 단일 업데이트
Future<Map<String, dynamic>> updateRepeatTodo() async {
  Dio().put("path", data: {

  });
  return {};
}
/// repeat todo 이후 업데이트
Future<Map<String, dynamic>> updateRepeatLaterTodo() async {
  Dio().put("path", data: {

  });
  return {};
}

/// DELETE
/// 단일 todo 삭제
Future<Map<String, dynamic>> deleteTodo() async {
  Dio().delete("path", data: {

  });
  return {};
}

/// 이후 todo 삭제
Future<Map<String, dynamic>> deleteRepeatLaterTodo() async {
  Dio().delete("path", data: {

  });
  return {};
}