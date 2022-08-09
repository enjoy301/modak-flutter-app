import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/screens/common/common_invitation_screen.dart';
import 'package:modak_flutter_app/screens/auth/auth_landing_screen.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/services/auth_service.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';

class AuthProvider extends ChangeNotifier {
  /// auth 상태 관리
  bool _isRegisterProgress = PrefsUtil.getBool("is_register_progress") ?? false;

  bool get isRegisterProgress => _isRegisterProgress;

  void setIsRegisterProgress(bool isRegisterProgress) {
    PrefsUtil.setBool("is_register_progress", isRegisterProgress);
    _isRegisterProgress = isRegisterProgress;
  }

  /// page 관리
  static int maxPage = 2;

  int _page = 1;
  int get page => _page;

  void goPreviousPage(BuildContext context) {
    if (_page == 1) {
      showDialog(
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("회원가입을 중단하시겠습니까?"),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      PrefsUtil.setBool("is_register_progress", false);
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              AuthLandingScreen(),
                        ),
                        (route) => false,
                      );
                    },
                    child: Text("YES")),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("NO")),
              ],
            );
          },
          context: context);
    } else {
      _page -= 1;
    }
    notifyListeners();
  }

  void goNextPage(BuildContext context) async {
    if (_page == maxPage) {
      Map<String, dynamic> response = await signUp();

      /// TODO 실패시 어떻게 알려줄 건지 추가
      if (response["result"] == "FAIL") {
        return;
      } else if (response["result"] == "SUCCESS") {
        Future(() => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => CommonInvitationScreen(withSkipButton: true,))));
      }
    } else {
      _page += 1;
    }
    notifyListeners();
  }

  // 다음 페이지로 넘어가도 되는지 확인
  bool getValidity() {
    switch (_page) {
      case 1:
        return getFirstPageValidity();
      case 2:
        return getSecondPageValidity();
      default:
        return false;
    }
  }

  /// register_social_login

  String? _provider = PrefsUtil.getString("provider");
  int? _providerId = PrefsUtil.getInt("provider_id");

  String? get provider => _provider;
  int? get providerId => _providerId;

  void setProvider(String provider) {
    _provider = provider;
    PrefsUtil.setString("provider", provider);
  }

  void setProviderId(int providerId) {
    _providerId = providerId;
    PrefsUtil.setInt("provider_id", providerId);
  }

  /// register_name_agreement_screen 첫 번째 페이지

  String _name = PrefsUtil.getString("user_name") ?? "";
  DateTime? _birthDay = PrefsUtil.getString("user_birth_day") == null
      ? null
      : DateTime.tryParse(PrefsUtil.getString("user_birth_day")!);
  bool _isLunar = PrefsUtil.getBool("user_is_lunar") ?? false;
  bool _isPrivateInformationAgreed = false;
  bool _isOperatingPolicyAgreed = false;

  String get name => _name;
  DateTime? get birthDay => _birthDay;
  bool get isLunar => _isLunar;
  bool get isPrivateInformationAgreed => _isPrivateInformationAgreed;
  bool get isOperatingPolicyAgreed => _isOperatingPolicyAgreed;

  void setName(String name) {
    _name = name;
    PrefsUtil.setString("user_name", name);
    notifyListeners();
  }

  void setBirthDay(DateTime birthDay) {
    _birthDay = birthDay;
    PrefsUtil.setString(
        "user_birth_day", DateFormat("yyyy-MM-dd").format(birthDay));
    notifyListeners();
  }

  void setIsLunar(bool isLunar) {
    _isLunar = isLunar;
    PrefsUtil.setBool("user_is_lunar", isLunar);
    notifyListeners();
  }

  void toggleIsLunar() {
    _isLunar = !_isLunar;
    notifyListeners();
  }

  void toggleIsPrivateInformationAgreed() {
    _isPrivateInformationAgreed = !_isPrivateInformationAgreed;
    notifyListeners();
  }

  void toggleIsOperatingPolicyAgreed() {
    _isOperatingPolicyAgreed = !_isOperatingPolicyAgreed;
    notifyListeners();
  }

  // 첫 번째 페이지 validity 확인
  bool getFirstPageValidity() {
    return _name.length >= 2 &&
        _birthDay != null &&
        _isPrivateInformationAgreed &&
        _isOperatingPolicyAgreed;
  }

  /// register_role_screen 두 번째 페이지

  FamilyType? _role = PrefsUtil.getString("user_role").toFamilyType();

  FamilyType? get role => _role;

  void setRole(FamilyType role) {
    _role = role;
    PrefsUtil.setString("user_role", role.toString());
    notifyListeners();
  }

  // 두 번째 페이지 validity 확인
  bool getSecondPageValidity() {
    return _role != null;
  }

  void clearCache() {
    _provider = null;
    _providerId = null;
    PrefsUtil.remove('user_provider');
    PrefsUtil.remove('user_provider_id');
  }
}
