import 'dart:developer';
import 'package:hive/hive.dart';
import 'package:modak_flutter_app/constant/strings.dart';

class LocalDataSource {
  LocalDataSource._create();

  static Future<LocalDataSource> create() async {
    LocalDataSource localDataSource = LocalDataSource._create();
    return localDataSource;
  }

  static Box authBox = Hive.box("auth");
  static Box userBox = Hive.box("user");
  static Box todoBox = Hive.box("todo");
  static Box chatBox = Hive.box("chat");
  static Box albumBox = Hive.box("album");

  /// auth
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

  Future<bool> updateName(String name) async {
    return tryFunction(() async => await authBox.put(Strings.name, name));
  }

  Future<bool> updateBirthDay(String birthDay) async {
    return tryFunction(
        () async => await authBox.put(Strings.birthDay, birthDay));
  }

  Future<bool> updateIsLunar(bool isLunar) async {
    return tryFunction(() async => await authBox.put(Strings.isLunar, isLunar));
  }

  Future<bool> updateRole(String role) async {
    List<String> roleType = [
      Strings.dad,
      Strings.mom,
      Strings.son,
      Strings.dau
    ];
    if (!roleType.contains(role)) {
      Future.error("wrong type");
      return false;
    }
    return tryFunction(() async => await authBox.put(Strings.role, role));
  }

  Future<bool> updateIsRegisterProgress(bool isRegisterProgress) async {
    return tryFunction(() async =>
        await authBox.put(Strings.isRegisterProgress, isRegisterProgress));
  }

  /// user


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
