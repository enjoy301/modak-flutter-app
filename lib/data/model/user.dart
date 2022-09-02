import 'package:hive/hive.dart';

part 'user.g.dart';

@HiveType(typeId: 0)
class User {
  @HiveField(0)
  String name;

  @HiveField(1)
  String birthDay;

  @HiveField(2)
  bool isLunar;

  @HiveField(3)
  String role;

  @HiveField(4)
  String fcmToken;

  User(
      {required this.name,
      required this.birthDay,
      required this.isLunar,
      required this.role,
      required this.fcmToken});
}
