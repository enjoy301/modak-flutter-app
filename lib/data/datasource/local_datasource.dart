import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/model/user.dart';

class LocalDataSource {
  LocalDataSource._privateConstructor();
  static final LocalDataSource _instance =
      LocalDataSource._privateConstructor();

  factory LocalDataSource() {
    return _instance;
  }

  static Box authBox = Hive.box("auth");
  static Box userBox = Hive.box("user");
  static Box todoBox = Hive.box("todo");
  // static Box chatBox = Hive.box("chat");
  // static Box albumBox = Hive.box("album");

  /// auth
  /// └ getters
  String? getName() {
    String? name = authBox.get(Strings.name);
    return name;
  }

  String? getBirthDay() {
    String? birthDay = authBox.get(Strings.birthDay);
    return birthDay;
  }

  bool? getIsLunar() {
    bool? isLunar = authBox.get(Strings.isLunar);
    return isLunar;
  }

  String? getRole() {
    String? role = authBox.get(Strings.role);
    return role;
  }

  bool? getIsRegisterProgress() {
    bool? isRegisterProgress = authBox.get(Strings.isRegisterProgress);
    return isRegisterProgress;
  }

  /// auth
  /// └ setters
  Future<bool> updateName(String name) async {
    return tryFunction(
      () async => await authBox.put(
        Strings.name,
        name,
      ),
    );
  }

  Future<bool> updateBirthDay(String birthDay) async {
    return tryFunction(
      () async => await authBox.put(
        Strings.birthDay,
        birthDay,
      ),
    );
  }

  Future<bool> updateIsLunar(bool isLunar) async {
    return tryFunction(
      () async => await authBox.put(
        Strings.isLunar,
        isLunar,
      ),
    );
  }

  Future<bool> updateRole(String role) async {
    List<String> roleType = [
      Strings.dad,
      Strings.mom,
      Strings.son,
      Strings.dau,
    ];
    if (!roleType.contains(role)) {
      Future.error("wrong type");
      return false;
    }
    return tryFunction(
      () async => await authBox.put(
        Strings.role,
        role,
      ),
    );
  }

  Future<bool> updateIsRegisterProgress(bool isRegisterProgress) async {
    return tryFunction(
      () async => await authBox.put(
        Strings.isRegisterProgress,
        isRegisterProgress,
      ),
    );
  }

  /// user
  /// └ getters
  User? getMe() {
    User? user = userBox.get(Strings.me);
    return user;
  }

  List<User> getFamilyMembers() {
    List<dynamic> rawFamilyMembers = userBox.get(Strings.familyMembers) ?? [];
    List<User> familyMembers = List<User>.from(rawFamilyMembers);
    return familyMembers;
  }

  int getSizeSettings() {
    int sizeSettings = userBox.get(Strings.sizeSettings) ?? 0;
    return sizeSettings;
  }

  bool getIsTodoAlarmReceive() {
    bool isTodoAlarmReceive = userBox.get(Strings.isTodoAlarmReceive) ?? true;
    return isTodoAlarmReceive;
  }

  bool getIsChatAlarmReceive() {
    bool isChatAlarmReceive = userBox.get(Strings.isChatAlarmReceive) ?? true;
    return isChatAlarmReceive;
  }

  /// user
  /// └ setters
  Future<bool> updateMe(User user) async {
    return tryFunction(() async => await userBox.put(Strings.me, user));
  }

  Future<bool> updateFamilyMember(List<User> familyMembers) async {
    return tryFunction(
        () async => await userBox.put(Strings.familyMembers, familyMembers));
  }

  Future<bool> updateSizeSettings(int sizeSettings) async {
    return tryFunction(
        () async => await userBox.put(Strings.sizeSettings, sizeSettings));
  }

  Future<bool> updateTodoAlarmReceive(bool isTodoAlarmReceive) async {
    return tryFunction(() async =>
        await userBox.put(Strings.isTodoAlarmReceive, isTodoAlarmReceive));
  }

  Future<bool> updateChatAlarmReceive(bool isChatAlarmReceive) async {
    return tryFunction(() async =>
        await userBox.put(Strings.isChatAlarmReceive, isChatAlarmReceive));
  }

  /// util
  bool tryFunction(Function() function) {
    try {
      function.call();
    } catch (e) {
      log(e.toString());
      return false;
    }
    return true;
  }
}
