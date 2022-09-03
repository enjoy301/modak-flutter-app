import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@unfreezed
class User with _$User {
  @HiveType(typeId: 0)
  factory User(
      {@HiveField(0) required String name,
      @HiveField(1) required String birthDay,
      @HiveField(2) required bool isLunar,
      @HiveField(3) required String role,
      @HiveField(4) required String fcmToken,
      @HiveField(5) required String color}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
