import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/datasource/local_datasource.dart';
import 'package:modak_flutter_app/data/datasource/remote_datasource.dart';
import 'package:modak_flutter_app/data/model/user.dart';

/// response: returns response which should be updated
/// message: acknowledges result of request

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

  Future<Map<String, dynamic>> tokenLogin() async {
    Map<String, dynamic> response = await remoteDataSource!.tokenLogin();
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

  Future<Map<String, dynamic>> kakaoSocialLogin() async {
    bool isKakaoLoginSuccess = await remoteDataSource!.kakaoLogin();
    if (isKakaoLoginSuccess) {
      Map<String, dynamic> response = await remoteDataSource!.socialLogin();
      print(response['response']);
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
      } else if (response[Strings.message] == "NoSuchMemberException") {
        return {Strings.message: Strings.noUser};
      }
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> signUp() async {
    String? name = localDataSource!.getName();
    String? birthDay = localDataSource!.getBirthDay();
    bool? isLunar = localDataSource!.getIsLunar();
    String? role = localDataSource!.getRole();

    if ([name, birthDay, isLunar, role].contains(null)) {
      return {Strings.message: Strings.noValue};
    }
    Map<String, dynamic> response = await remoteDataSource!
        .signUp(name!, birthDay!, isLunar! ? 1 : 0, role!, "fcmToken", -1);
    if (response[Strings.result]) {
      await localDataSource!.updateIsRegisterProgress(false);

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

  Future<Map<String, dynamic>> updateMeInfo(User user) async {
    Map<String, dynamic> response = await remoteDataSource!.updateMeInfo(user);
    if (response[Strings.result]) {
      await localDataSource!.updateMe(user);

      /// TODO
      return {Strings.message: Strings.success};
    }
    return {Strings.message: Strings.fail};
  }

  Future<Map<String, dynamic>> updateMeTag(List<String> tags) async {
    Map<String, dynamic> response = await remoteDataSource!.updateMeTag(tags);
    if (response[Strings.result]) {
      User? user = localDataSource!.getMe();
      if (user != null) user.timeTags == tags;
      localDataSource!.updateMe(user!);

      return {
        Strings.response: {Strings.timeTag: tags},
        Strings.message: Strings.success
      };
    }
    return {Strings.message: Strings.fail};
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

  User? getMe() {
    return localDataSource!.getMe();
  }

  List<User> getFamilyMembers() {
    return localDataSource!.getFamilyMembers();
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

  void setMe(User user) {
    localDataSource!.updateMe(user);
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
        timeTags: meRaw['tags'] == null ? List<String>.from([]) : List<String>.from(meRaw['tags']));

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
    await localDataSource!.updateMe(me);
    await localDataSource!.updateFamilyMember(familyMembers);

    return [me, familyMembers];
  }
}
