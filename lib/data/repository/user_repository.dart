import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/dto/notification.dart';
import 'package:modak_flutter_app/data/dto/user.dart';

/// response: returns response which should be updated
/// message: acknowledges result of request

class UserRepository {
  UserRepository._privateConstructor() {
    localDataSource = LocalDataSource();
    remoteDataSource = RemoteDataSource();
  }

  factory UserRepository() {
    return _instance;
  }

  static final UserRepository _instance = UserRepository._privateConstructor();
  static late final LocalDataSource localDataSource;
  static late final RemoteDataSource remoteDataSource;

  Future<Map<String, dynamic>> tokenLogin() async {
    Map<String, dynamic> response = await remoteDataSource.tokenLogin();
    if (response[Strings.result]) {
      List updateResult = await updateMeAndFamilyInfo(response);
      User me = updateResult[0];
      List<User> familyMembers = updateResult[1];

      return {
        Strings.response: {
          Strings.me: me,
          Strings.familyMembers: familyMembers,
        },
        Strings.message: Strings.success,
      };
    }
    return {
      Strings.message: Strings.fail,
    };
  }

  Future<Map<String, dynamic>> socialLogin(String type) async {
    bool isSuccessful = false;

    /// 타입에 따라 성공적으로 각각의 provider 요청에 성공했는지 보는 함수
    switch (type) {
      case "KAKAO":
        isSuccessful = await remoteDataSource.kakaoLogin();
        break;
      case "APPLE":
        Map response = await remoteDataSource.appleLogin();
        isSuccessful = response[Strings.result];
        localDataSource.updateName(response[Strings.name]);
        break;
    }

    /// 성공했을 때 처리하는 함수
    if (isSuccessful) {
      Map<String, dynamic> response = await remoteDataSource.socialLogin();
      if (response[Strings.result]) {
        List updateResult = await updateMeAndFamilyInfo(response);
        User me = updateResult[0];
        List<User> familyMembers = updateResult[1];
        return {
          Strings.response: {
            Strings.me: me,
            Strings.familyMembers: familyMembers
          },
          Strings.message: Strings.success,
        };
      }
      if (response[Strings.message] == "NoSuchMemberException") {
        return {
          Strings.message: Strings.noUser,
        };
      }
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> signUp() async {
    String? name = localDataSource.getName();
    String? birthDay = localDataSource.getBirthDay();
    bool? isLunar = localDataSource.getIsLunar() ?? false;
    String? role = localDataSource.getRole();

    if ([name, birthDay, role].contains(null)) {
      return {Strings.message: Strings.noValue};
    }
    Map<String, dynamic> response = await remoteDataSource.signUp(
        name!, birthDay!, isLunar ? 1 : 0, role!, "fcmToken", -1);
    if (response[Strings.result]) {
      await localDataSource.updateIsRegisterProgress(false);

      List updateResult = await updateMeAndFamilyInfo(response);
      User me = updateResult[0];
      List<User> familyMembers = updateResult[1];

      return {
        Strings.response: {
          Strings.me: me,
          Strings.familyMembers: familyMembers,
        },
        Strings.message: Strings.success
      };
    }
    if (response[Strings.message] == "MemberAlreadyExistsException") {
      return {Strings.message: Strings.valueAlreadyExist};
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> updateMeInfo(User beforeMe, User me) async {
    Map<String, dynamic> response = await remoteDataSource.updateMeInfo(me);
    if (response[Strings.result]) {
      List<User> familyMembers = localDataSource.getFamilyMembers();
      List<User> newFamilyMembers = [me];
      for (User familyMember in familyMembers) {
        if (beforeMe.memberId != familyMember.memberId) {
          newFamilyMembers.add(familyMember);
        }
      }
      await localDataSource.updateMe(me);
      await localDataSource.updateFamilyMember(newFamilyMembers);

      return {
        Strings.message: Strings.success,
        Strings.response: {
          Strings.me: me,
          Strings.familyMembers: newFamilyMembers
        }
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> deleteMe() async {
    Map<String, dynamic> response = await remoteDataSource.deleteMe();
    return {
      Strings.message: response[Strings.result] ? Strings.success : Strings.fail
    };
  }

  Future<Map<String, dynamic>> updateMeTag(List<String> tags) async {
    Map<String, dynamic> response = await remoteDataSource.updateMeTag(tags);
    if (response[Strings.result]) {
      User? user = localDataSource.getMe();
      if (user != null) user.timeTags == tags;
      localDataSource.updateMe(user!);

      return {
        Strings.response: {Strings.timeTag: tags},
        Strings.message: Strings.success
      };
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> updateFamilyId(String familyCode) async {
    familyCode = familyCode.trim();
    Map<String, dynamic> response =
        await remoteDataSource.updateFamilyId(familyCode);
    if (response[Strings.result]) {
      return {Strings.message: Strings.success};
    }
    return {Strings.message: Strings.fail};
  }

  String? getName() {
    return localDataSource.getName();
  }

  DateTime? getBirthDay() {
    String? birthDay = localDataSource.getBirthDay();
    if (birthDay == null) {
      return null;
    }
    DateTime birthDayDate = DateTime.parse(birthDay);
    return birthDayDate;
  }

  bool? getIsLunar() {
    return localDataSource.getIsLunar();
  }

  String? getRole() {
    return localDataSource.getRole();
  }

  bool? getIsRegisterProgress() {
    return localDataSource.getIsRegisterProgress();
  }

  User? getMe() {
    return localDataSource.getMe();
  }

  List<User> getFamilyMembers() {
    return localDataSource.getFamilyMembers();
  }

  int getSizeSettings() {
    return localDataSource.getSizeSettings();
  }

  bool getTodoAlarmReceive() {
    return localDataSource.getIsTodoAlarmReceive();
  }

  bool getChatAlarmReceive() {
    return localDataSource.getIsChatAlarmReceive();
  }

  List<Noti> getNotifications() {
    return localDataSource.getNotifications();
  }

  List<Noti> getArchiveNotifications() {
    return localDataSource.getArchiveNotifications();
  }

  void setName(String name) async {
    await localDataSource.updateName(name);
  }

  void setBirthDay(DateTime birthDay) async {
    await localDataSource
        .updateBirthDay(DateFormat("yyyy-MM-dd").format(birthDay));
  }

  void setIsLunar(bool isLunar) async {
    await localDataSource.updateIsLunar(isLunar);
  }

  void setRole(String role) async {
    await localDataSource.updateRole(role);
  }

  void setIsRegisterProgress(bool isRegisterProgress) async {
    await localDataSource.updateIsRegisterProgress(isRegisterProgress);
  }

  void setMe(User user) async {
    await localDataSource.updateMe(user);
  }

  void setSizeSettings(int sizeSettings) async {
    await localDataSource.updateSizeSettings(sizeSettings);
  }

  void setTodoAlarmReceive(bool todoAlarmReceive) async {
    await localDataSource.updateTodoAlarmReceive(todoAlarmReceive);
  }

  void setChatAlarmReceive(bool chatAlarmReceive) async {
    await localDataSource.updateChatAlarmReceive(chatAlarmReceive);
  }

  void setNotifications(List<Noti> notifications) async {
    await localDataSource.updateNotifications(notifications);
  }

  void setArchiveNotifications(List<Noti> archiveNotifications) async {
    await localDataSource.updateArchiveNotifications(archiveNotifications);
  }

  clearStorage() async {
    await localDataSource.clearStorage();
    await remoteDataSource.clearStorage();
  }

  Future<List> updateMeAndFamilyInfo(Map<String, dynamic> response) async {
    Map<String, dynamic> meRaw =
        response['response'].data['data'][Strings.memberResult];
    User me = User(
        memberId: meRaw[Strings.memberId],
        name: meRaw[Strings.name],
        birthDay: meRaw[Strings.birthDay],
        isLunar: meRaw[Strings.isLunar] == 1 ? true : false,
        role: meRaw[Strings.role],
        fcmToken: "",
        color: meRaw[Strings.color],
        timeTags: meRaw['tags'] == null
            ? List<String>.from([])
            : List<String>.from(meRaw['tags']));

    List<User> familyMembers = [me];
    for (Map<String, dynamic> familyMemberRaw
        in response['response'].data['data'][Strings.familyMembersResult]) {
      User familyMember = User(
          memberId: familyMemberRaw[Strings.memberId],
          name: familyMemberRaw[Strings.name],
          birthDay: familyMemberRaw[Strings.birthDay],
          isLunar: familyMemberRaw[Strings.isLunar] == 1 ? true : false,
          role: familyMemberRaw[Strings.role],
          fcmToken: "others",
          color: familyMemberRaw['color'],
          timeTags: []);
      familyMembers.add(familyMember);
    }
    await localDataSource.updateMe(me);
    await localDataSource.updateFamilyMember(familyMembers);

    return [me, familyMembers];
  }
}
