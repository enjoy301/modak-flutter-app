import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'todo.freezed.dart';
part 'todo.g.dart';

@unfreezed
class Todo with _$Todo {
  @HiveType(typeId: 1)
  factory Todo({
    @HiveField(0) required int todoId,
    @HiveField(1) required int groupTodoId,
    @HiveField(2) required int memberId,
    @HiveField(3) required String title,
    @HiveField(4) required String color,
    @HiveField(5) required bool isDone,
    @HiveField(6) required String? timeTag,
    @HiveField(7) required String? repeatTag,
    @HiveField(8) required List<int>? repeat,
    @HiveField(9) required String? memo,
    @HiveField(10) required String memoColor,
    @HiveField(11) required String date,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}
