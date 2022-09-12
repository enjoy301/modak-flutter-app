import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user.g.dart';
part 'user.freezed.dart';

@unfreezed
class User with _$User {
  @HiveType(typeId: 0)
  factory User(
      {@HiveField(0) required int memberId,
      @HiveField(1) required String name,
      @HiveField(2) required String birthDay,
      @HiveField(3) required bool isLunar,
      @HiveField(4) required String role,
      @HiveField(5) required String fcmToken,
      @HiveField(6) required String color,
      @HiveField(7) required List<String> timeTags}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
