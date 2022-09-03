import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/model/user.dart';

class UserRepository {
  UserRepository._create();

  static Future<UserRepository> create() async {
    UserRepository albumRepository = UserRepository._create();
    localDataSource ??= await LocalDataSource.create();
    remoteDataSource ??= RemoteDataSource();
    return albumRepository;
  }

  static LocalDataSource? localDataSource;
  static RemoteDataSource? remoteDataSource;

  Future<String> tokenLogin() async {
    Map<String, dynamic> response = await remoteDataSource!.tokenLogin();
    print(response['message']);
    if (response[Strings.result]) {
      return Strings.success;
    }
    return Strings.fail;
  }

  Future<String> kakaoSocialLogin() async {
    bool isKakaoLoginSuccess = await remoteDataSource!.kakaoLogin();
    if (isKakaoLoginSuccess) {
      Map<String, dynamic> response = await remoteDataSource!.socialLogin();
      if (response[Strings.result]) {
        final userInfo =
            response[Strings.response].data['data']['memberResult'];
        localDataSource!.updateMe(User(
            name: userInfo[Strings.name],
            birthDay: userInfo[Strings.birthDay],
            isLunar: userInfo[Strings.isLunar] == 1 ? true : false,
            role: userInfo[Strings.role],
            fcmToken: "fcmToken",
            color: userInfo[Strings.color]));
        return Strings.success;
      } else if (response[Strings.message] == "NoSuchMemberException") {
        return Strings.noUser;
      }
    }
    return Strings.fail;
  }

  Future<String> signUp() async {
    String? name = localDataSource!.getName();
    String? birthDay = localDataSource!.getBirthDay();
    bool? isLunar = localDataSource!.getIsLunar();
    String? role = localDataSource!.getRole();

    if ([name, birthDay, isLunar, role].contains(null)) {
      return Strings.noValue;
    }
    Map<String, dynamic> response = await remoteDataSource!
        .signUp(name!, birthDay!, isLunar! ? 1 : 0, role!, "fcmToken", -1);
    if (response[Strings.result]) {
      await localDataSource!.updateIsRegisterProgress(false);
      return Strings.success;
    }
    if (response[Strings.message] == "MemberAlreadyExistsException") {
      return Strings.valueAlreadyExist;
    }
    return Strings.fail;
  }

  String? getName() {
    return localDataSource!.getName();
  }

  DateTime? getBirthDay() {
    String? birthDay = localDataSource!.getBirthDay();
    if (birthDay == null) {
      return null;
    }
    DateTime birthDayDate = DateTime.parse(birthDay);
    return birthDayDate;
  }

  bool? getIsLunar() {
    return localDataSource!.getIsLunar();
  }

  String? getRole() {
    return localDataSource!.getRole();
  }

  bool? getIsRegisterProgress() {
    return localDataSource!.getIsRegisterProgress();
  }

  void setName(String name) {
    localDataSource!.updateName(name);
  }

  void setBirthDay(DateTime birthDay) {
    localDataSource!.updateBirthDay(DateFormat("yyyy-MM-dd").format(birthDay));
  }

  void setIsLunar(bool isLunar) {
    localDataSource!.updateIsLunar(isLunar);
  }

  void setRole(String role) {
    localDataSource!.updateRole(role);
  }

  void setIsRegisterProgress(bool isRegisterProgress) {
    localDataSource!.updateIsRegisterProgress(isRegisterProgress);
  }
}
