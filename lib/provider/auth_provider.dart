import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/screens/landing_bottomtab_navigator.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';

class AuthProvider extends ChangeNotifier {
  /// page 관리
  static int maxPage = 2;

  int _page = 1;
  int get page => _page;

  void goPreviousPage(BuildContext context) {
    if (_page == 1) {
      Navigator.pop(context);
    } else {
      _page -= 1;
    }
    notifyListeners();
  }

  void goNextPage(BuildContext context) {
    if (_page == maxPage) {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => LandingBottomNavigator()));
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

  String? _provider;
  int? _providerId;

  String? get provider => _provider;
  int? get providerId => _providerId;

  void setProvider(String provider) {
    _provider = provider;
    Prefs.setString("user_provider", provider);
  }

  void setProviderId(int providerId) {
    _providerId = providerId;
    Prefs.setInt("user_provider_id", providerId);
  }

  /// register_name_agreement_screen 첫 번째 페이지

  String _name = "";
  DateTime? _birthDay;
  bool _isLunar = false;
  bool _isPrivateInformationAgreed = false;
  bool _isOperatingPolicyAgreed = false;

  String get name => _name;
  DateTime? get birthDay => _birthDay;
  bool get isLunar => _isLunar;
  bool get isPrivateInformationAgreed => _isPrivateInformationAgreed;
  bool get isOperatingPolicyAgreed => _isOperatingPolicyAgreed;

  void setName(String name) {
    _name = name;
    Prefs.setString("user_name", name);
    notifyListeners();
  }

  void setBirthDay(DateTime birthDay) {
    _birthDay = birthDay;
    Prefs.setString("user_birth_day", DateFormat("yyyy-MM-dd").format(birthDay));
    notifyListeners();
  }

  void setIsLunar(bool isLunar) {
    _isLunar = isLunar;
    Prefs.setBool("user_is_lunar", isLunar);
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

  FamilyType? _role;

  FamilyType? get role => _role;

  void setRole(FamilyType role) {
    _role = role;
    Prefs.setString("user_role", role.toString());
    notifyListeners();
  }

  // 두 번째 페이지 validity 확인
  bool getSecondPageValidity() {
    return _role != null;
  }

  void clearCache() {
    _provider = null;
    _providerId = null;
    Prefs.remove('user_provider');
    Prefs.remove('user_provider_id');
  }

}
