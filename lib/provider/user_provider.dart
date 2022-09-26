import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/model/user.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  init() async {
    _userRepository = await UserRepository.create();
    _me = _userRepository!.getMe();
    _familyMembers = _userRepository!.getFamilyMembers();
    _sizeSettings = _userRepository!.getSizeSettings();
  }

  UserRepository? _userRepository;
  List<double> fontScale = [1.0, 1.5, 2.0];

  double getFontScale() {
    return fontScale[_sizeSettings];
  }

  User? _me;
  List<User> _familyMembers = [];
  int _sizeSettings = 0;

  User? get me => _me;
  List<User> get familyMembers => _familyMembers;
  int get sizeSettings => _sizeSettings;

  List<User> get familyMembersWithoutMe {
    List<User> familyMembersWithoutMe = [];
    for (User familyMember in _familyMembers!) {
      if (familyMember.name != me?.name) {
        familyMembersWithoutMe.add(familyMember);
      }
    }
    return familyMembersWithoutMe;
  }

  set me(User? me) {
    if (me == null) return;
    _me = me;
    _userRepository!.setMe(me);
    notifyListeners();
  }

  set familyMembers(List<User> familyMembers) {
    _familyMembers = familyMembers;
    notifyListeners();
  }

  set sizeSettings(int sizeSettings) {
    _sizeSettings = sizeSettings;
    _userRepository!.setSizeSettings(sizeSettings);
    notifyListeners();
  }

  List<String> extractName(List<User> users) {
    List<String> familyNames = [];
    for (User user in users) {
      familyNames.add(user.name);
    }
    return familyNames;
  }

  User? findUserById(int id) {
    for (User familyMember in _familyMembers) {
      if (familyMember.memberId == id) {
        return familyMember;
      }
    }
    return null;
  }
  updateMeTag(List<String> timeTags) async {
    Map<String, dynamic> response = await _userRepository!.updateMeTag(timeTags);
    switch (response[Strings.message]) {
      case Strings.success:
        Fluttertoast.showToast(msg: "성공적으로 업데이트");
        _me!.timeTags = timeTags;
        notifyListeners();
        break;
      case Strings.fail:
        Fluttertoast.showToast(msg: "업데이트에 실패하셨습니다");
        break;
    }
  }

  addMeTag(String tag) async {
    updateMeTag([..._me!.timeTags, tag]);
  }

  removeMeTag(String tag) async {
    me!.timeTags.remove(tag);
    updateMeTag(me!.timeTags);
  }




}
