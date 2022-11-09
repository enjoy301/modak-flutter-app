// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return _Todo.fromJson(json);
}

/// @nodoc
mixin _$Todo {
  @HiveField(0)
  int get todoId => throw _privateConstructorUsedError;
  @HiveField(0)
  set todoId(int value) => throw _privateConstructorUsedError;
  @HiveField(1)
  int get groupTodoId => throw _privateConstructorUsedError;
  @HiveField(1)
  set groupTodoId(int value) => throw _privateConstructorUsedError;
  @HiveField(2)
  int get memberId => throw _privateConstructorUsedError;
  @HiveField(2)
  set memberId(int value) => throw _privateConstructorUsedError;
  @HiveField(3)
  String get title => throw _privateConstructorUsedError;
  @HiveField(3)
  set title(String value) => throw _privateConstructorUsedError;
  @HiveField(4)
  String get color => throw _privateConstructorUsedError;
  @HiveField(4)
  set color(String value) => throw _privateConstructorUsedError;
  @HiveField(5)
  bool get isDone => throw _privateConstructorUsedError;
  @HiveField(5)
  set isDone(bool value) => throw _privateConstructorUsedError;
  @HiveField(6)
  String? get timeTag => throw _privateConstructorUsedError;
  @HiveField(6)
  set timeTag(String? value) => throw _privateConstructorUsedError;
  @HiveField(7)
  String? get repeatTag => throw _privateConstructorUsedError;
  @HiveField(7)
  set repeatTag(String? value) => throw _privateConstructorUsedError;
  @HiveField(8)
  List<int>? get repeat => throw _privateConstructorUsedError;
  @HiveField(8)
  set repeat(List<int>? value) => throw _privateConstructorUsedError;
  @HiveField(9)
  String? get memo => throw _privateConstructorUsedError;
  @HiveField(9)
  set memo(String? value) => throw _privateConstructorUsedError;
  @HiveField(10)
  String get memoColor => throw _privateConstructorUsedError;
  @HiveField(10)
  set memoColor(String value) => throw _privateConstructorUsedError;
  @HiveField(11)
  String get date => throw _privateConstructorUsedError;
  @HiveField(11)
  set date(String value) => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoCopyWith<Todo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) then) =
      _$TodoCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) int todoId,
      @HiveField(1) int groupTodoId,
      @HiveField(2) int memberId,
      @HiveField(3) String title,
      @HiveField(4) String color,
      @HiveField(5) bool isDone,
      @HiveField(6) String? timeTag,
      @HiveField(7) String? repeatTag,
      @HiveField(8) List<int>? repeat,
      @HiveField(9) String? memo,
      @HiveField(10) String memoColor,
      @HiveField(11) String date});
}

/// @nodoc
class _$TodoCopyWithImpl<$Res> implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._value, this._then);

  final Todo _value;
  // ignore: unused_field
  final $Res Function(Todo) _then;

  @override
  $Res call({
    Object? todoId = freezed,
    Object? groupTodoId = freezed,
    Object? memberId = freezed,
    Object? title = freezed,
    Object? color = freezed,
    Object? isDone = freezed,
    Object? timeTag = freezed,
    Object? repeatTag = freezed,
    Object? repeat = freezed,
    Object? memo = freezed,
    Object? memoColor = freezed,
    Object? date = freezed,
  }) {
    return _then(_value.copyWith(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as int,
      groupTodoId: groupTodoId == freezed
          ? _value.groupTodoId
          : groupTodoId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: memberId == freezed
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      timeTag: timeTag == freezed
          ? _value.timeTag
          : timeTag // ignore: cast_nullable_to_non_nullable
              as String?,
      repeatTag: repeatTag == freezed
          ? _value.repeatTag
          : repeatTag // ignore: cast_nullable_to_non_nullable
              as String?,
      repeat: repeat == freezed
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      memoColor: memoColor == freezed
          ? _value.memoColor
          : memoColor // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$$_TodoCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$$_TodoCopyWith(_$_Todo value, $Res Function(_$_Todo) then) =
      __$$_TodoCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) int todoId,
      @HiveField(1) int groupTodoId,
      @HiveField(2) int memberId,
      @HiveField(3) String title,
      @HiveField(4) String color,
      @HiveField(5) bool isDone,
      @HiveField(6) String? timeTag,
      @HiveField(7) String? repeatTag,
      @HiveField(8) List<int>? repeat,
      @HiveField(9) String? memo,
      @HiveField(10) String memoColor,
      @HiveField(11) String date});
}

/// @nodoc
class __$$_TodoCopyWithImpl<$Res> extends _$TodoCopyWithImpl<$Res>
    implements _$$_TodoCopyWith<$Res> {
  __$$_TodoCopyWithImpl(_$_Todo _value, $Res Function(_$_Todo) _then)
      : super(_value, (v) => _then(v as _$_Todo));

  @override
  _$_Todo get _value => super._value as _$_Todo;

  @override
  $Res call({
    Object? todoId = freezed,
    Object? groupTodoId = freezed,
    Object? memberId = freezed,
    Object? title = freezed,
    Object? color = freezed,
    Object? isDone = freezed,
    Object? timeTag = freezed,
    Object? repeatTag = freezed,
    Object? repeat = freezed,
    Object? memo = freezed,
    Object? memoColor = freezed,
    Object? date = freezed,
  }) {
    return _then(_$_Todo(
      todoId: todoId == freezed
          ? _value.todoId
          : todoId // ignore: cast_nullable_to_non_nullable
              as int,
      groupTodoId: groupTodoId == freezed
          ? _value.groupTodoId
          : groupTodoId // ignore: cast_nullable_to_non_nullable
              as int,
      memberId: memberId == freezed
          ? _value.memberId
          : memberId // ignore: cast_nullable_to_non_nullable
              as int,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      color: color == freezed
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as String,
      isDone: isDone == freezed
          ? _value.isDone
          : isDone // ignore: cast_nullable_to_non_nullable
              as bool,
      timeTag: timeTag == freezed
          ? _value.timeTag
          : timeTag // ignore: cast_nullable_to_non_nullable
              as String?,
      repeatTag: repeatTag == freezed
          ? _value.repeatTag
          : repeatTag // ignore: cast_nullable_to_non_nullable
              as String?,
      repeat: repeat == freezed
          ? _value.repeat
          : repeat // ignore: cast_nullable_to_non_nullable
              as List<int>?,
      memo: memo == freezed
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
      memoColor: memoColor == freezed
          ? _value.memoColor
          : memoColor // ignore: cast_nullable_to_non_nullable
              as String,
      date: date == freezed
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
@HiveType(typeId: 1)
class _$_Todo implements _Todo {
  _$_Todo(
      {@HiveField(0) required this.todoId,
      @HiveField(1) required this.groupTodoId,
      @HiveField(2) required this.memberId,
      @HiveField(3) required this.title,
      @HiveField(4) required this.color,
      @HiveField(5) required this.isDone,
      @HiveField(6) required this.timeTag,
      @HiveField(7) required this.repeatTag,
      @HiveField(8) required this.repeat,
      @HiveField(9) required this.memo,
      @HiveField(10) required this.memoColor,
      @HiveField(11) required this.date});

  factory _$_Todo.fromJson(Map<String, dynamic> json) => _$$_TodoFromJson(json);

  @override
  @HiveField(0)
  int todoId;
  @override
  @HiveField(1)
  int groupTodoId;
  @override
  @HiveField(2)
  int memberId;
  @override
  @HiveField(3)
  String title;
  @override
  @HiveField(4)
  String color;
  @override
  @HiveField(5)
  bool isDone;
  @override
  @HiveField(6)
  String? timeTag;
  @override
  @HiveField(7)
  String? repeatTag;
  @override
  @HiveField(8)
  List<int>? repeat;
  @override
  @HiveField(9)
  String? memo;
  @override
  @HiveField(10)
  String memoColor;
  @override
  @HiveField(11)
  String date;

  @override
  String toString() {
    return 'Todo(todoId: $todoId, groupTodoId: $groupTodoId, memberId: $memberId, title: $title, color: $color, isDone: $isDone, timeTag: $timeTag, repeatTag: $repeatTag, repeat: $repeat, memo: $memo, memoColor: $memoColor, date: $date)';
  }

  @JsonKey(ignore: true)
  @override
  _$$_TodoCopyWith<_$_Todo> get copyWith =>
      __$$_TodoCopyWithImpl<_$_Todo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TodoToJson(
      this,
    );
  }
}

abstract class _Todo implements Todo {
  factory _Todo(
      {@HiveField(0) required int todoId,
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
      @HiveField(11) required String date}) = _$_Todo;

  factory _Todo.fromJson(Map<String, dynamic> json) = _$_Todo.fromJson;

  @override
  @HiveField(0)
  int get todoId;
  @HiveField(0)
  set todoId(int value);
  @override
  @HiveField(1)
  int get groupTodoId;
  @HiveField(1)
  set groupTodoId(int value);
  @override
  @HiveField(2)
  int get memberId;
  @HiveField(2)
  set memberId(int value);
  @override
  @HiveField(3)
  String get title;
  @HiveField(3)
  set title(String value);
  @override
  @HiveField(4)
  String get color;
  @HiveField(4)
  set color(String value);
  @override
  @HiveField(5)
  bool get isDone;
  @HiveField(5)
  set isDone(bool value);
  @override
  @HiveField(6)
  String? get timeTag;
  @HiveField(6)
  set timeTag(String? value);
  @override
  @HiveField(7)
  String? get repeatTag;
  @HiveField(7)
  set repeatTag(String? value);
  @override
  @HiveField(8)
  List<int>? get repeat;
  @HiveField(8)
  set repeat(List<int>? value);
  @override
  @HiveField(9)
  String? get memo;
  @HiveField(9)
  set memo(String? value);
  @override
  @HiveField(10)
  String get memoColor;
  @HiveField(10)
  set memoColor(String value);
  @override
  @HiveField(11)
  String get date;
  @HiveField(11)
  set date(String value);
  @override
  @JsonKey(ignore: true)
  _$$_TodoCopyWith<_$_Todo> get copyWith => throw _privateConstructorUsedError;
}
