import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';
import 'package:modak_flutter_app/ui/auth/register/register_name_agreement_screen.dart';
import 'package:modak_flutter_app/ui/auth/register/register_role_screen.dart';

class AuthRegisterVM extends ChangeNotifier {

  final List<String> _buttonText = [
    "다음으로",
    "회원가입",
  ];


  Future<void> init() async {
    _userRepository = await UserRepository.create();

    _name = _userRepository.getName() ?? "";
    _birthDay = _userRepository.getBirthDay();
    _isLunar = _userRepository.getIsLunar() ?? false;
    _role = _userRepository.getRole() ?? "";
    _userRepository.setIsRegisterProgress(true);
    notifyListeners();
  }

  late final UserRepository _userRepository;

  int _page = 0;
  String _name = "";
  DateTime? _birthDay;
  bool _isLunar = false;
  String _role = "";
  bool _isPrivateInformationAgreed = false;
  bool _isOperatingPolicyAgreed = false;

  int get page => _page;
  String get name => _name;
  DateTime? get birthDay => _birthDay;
  bool get isLunar => _isLunar;
  String get role => _role;
  bool get isPrivateInformationAgreed => _isPrivateInformationAgreed;
  bool get isOperatingPolicyAgreed => _isOperatingPolicyAgreed;

  set name(String name) {
    _name = name;
    _userRepository.setName(name);
    notifyListeners();
  }

  set birthDay(DateTime? birthDay) {
    _birthDay = birthDay;
    if (birthDay != null) _userRepository.setBirthDay(birthDay);
    notifyListeners();
  }

  set isLunar(bool isLunar) {
    _isLunar = isLunar;
    _userRepository.setIsLunar(isLunar);
    notifyListeners();
  }

  set role(String role) {
    _role = role;
    _userRepository.setRole(role);
    notifyListeners();
  }

  set isPrivateInformationAgreed(bool isPrivateInformationAgreed) {
    _isPrivateInformationAgreed = isPrivateInformationAgreed;
    notifyListeners();
  }

  set isOperatingPolicyAgreed(bool isOperatingPolicyAgreed) {
    _isOperatingPolicyAgreed = isOperatingPolicyAgreed;
    notifyListeners();
  }

  void goNextPage() {
    if (_page < 1) {
      _page += 1;
    } else {
      _trySignUp();
    }
    notifyListeners();
  }

  void goPreviousPage() {
    if (page > 0) {
      _page -= 1;
    } else {
      _userRepository.setIsRegisterProgress(false);
      Fluttertoast.showToast(msg: "회원가입 취소");
      Get.offAllNamed("/auth/landing");
    }
    notifyListeners();
  }

  bool getIsPageDone() {
    if (_page == 0) {
      return _name.length > 2 &&
          _birthDay != null &&
          _isPrivateInformationAgreed &&
          _isOperatingPolicyAgreed;
    } else if (_page == 1) {
      return _role != "";
    }
    return false;
  }

  Widget getPage(AuthRegisterVM provider, TextEditingController controller) {
    if (_page == 0) {
      return RegisterNameAgreementScreen(provider: provider, controller: controller,);
    } else if (_page == 1) {
      return RegisterRoleScreen(provider: provider,);
    }
    return RegisterRoleScreen(provider: provider,);
  }

  String getButtonText() {
    return _buttonText[page];
  }

  _trySignUp() async {
    String response = await _userRepository.signUp();
    switch(response) {
      case Strings.success:
        Fluttertoast.showToast(msg: "회원가입 성공");
        Get.offAllNamed("/main");
        break;
      case Strings.valueAlreadyExist:
        Fluttertoast.showToast(msg: "이미 계정이 존재합니다");
        Get.offAllNamed("/auth/landing");
        break;
      case Strings.noValue:
        Fluttertoast.showToast(msg: "입력되지 않은 값이 있습니다");
        break;
      case Strings.fail:
        Fluttertoast.showToast(msg: "예상치 못한 문제가 발생하였습니다");
    }
  }
}
