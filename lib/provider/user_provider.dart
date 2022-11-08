import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:modak_flutter_app/constant/strings.dart';
import 'package:modak_flutter_app/data/dto/notification.dart';
import 'package:modak_flutter_app/data/dto/user.dart';
import 'package:modak_flutter_app/data/repository/user_repository.dart';

class UserProvider extends ChangeNotifier {
  init() async {
    clear();
    _me = _userRepository.getMe();
    _familyMembers = _userRepository.getFamilyMembers();
    _sizeSettings = _userRepository.getSizeSettings();
    _todoAlarmReceive = _userRepository.getTodoAlarmReceive();
    _chatAlarmReceive = _userRepository.getChatAlarmReceive();
    notifications = _userRepository.getNotifications();
    archiveNotifications = _userRepository.getArchiveNotifications();
    notifyListeners();
  }

  final UserRepository _userRepository = UserRepository();
  List<double> fontScale = [1.0, 1.5, 2.0];

  double getFontScale() {
    return fontScale[_sizeSettings];
  }

  User? _me;
  List<User> _familyMembers = [];
  int _sizeSettings = 0;
  bool _todoAlarmReceive = true;
  bool _chatAlarmReceive = true;
  List<Noti> notifications = <Noti>[];
  List<Noti> archiveNotifications = <Noti>[];

  User? get me => _me;

  List<User> get familyMembers => _familyMembers;

  int get sizeSettings => _sizeSettings;

  bool get todoAlarmReceive => _todoAlarmReceive;

  bool get chatAlarmReceive => _chatAlarmReceive;

  List<User> get familyMembersWithoutMe {
    List<User> familyMembersWithoutMe = [];
    for (User familyMember in _familyMembers) {
      if (familyMember.memberId != me?.memberId) {
        familyMembersWithoutMe.add(familyMember);
      }
    }
    return familyMembersWithoutMe;
  }

  set me(User? me) {
    if (me == null) return;
    _me = me;
    _userRepository.setMe(me);
    notifyListeners();
  }

  set familyMembers(List<User> familyMembers) {
    _familyMembers = familyMembers;
    notifyListeners();
  }

  set sizeSettings(int sizeSettings) {
    _sizeSettings = sizeSettings;
    _userRepository.setSizeSettings(sizeSettings);
    notifyListeners();
  }

  set todoAlarmReceive(bool todoAlarmReceive) {
    _todoAlarmReceive = todoAlarmReceive;
    _userRepository.setTodoAlarmReceive(todoAlarmReceive);
    notifyListeners();
  }

  set chatAlarmReceive(bool chatAlarmReceive) {
    _chatAlarmReceive = chatAlarmReceive;
    _userRepository.setChatAlarmReceive(chatAlarmReceive);
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
    Map<String, dynamic> response = await _userRepository.updateMeTag(timeTags);
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

  logout(BuildContext context) async {
    await _userRepository.clearStorage();
    Get.offAndToNamed("/auth/splash");
  }

  withdraw(BuildContext context) async {
    Map<String, dynamic> response = await _userRepository.deleteMe();
    switch (response[Strings.message]) {
      case Strings.success:
        // ignore: use_build_context_synchronously
        logout(context);
        Fluttertoast.showToast(msg: "성공적으로 회원탈퇴");
        break;
      case Strings.fail:
        Fluttertoast.showToast(msg: "회원탈퇴 실패");
        break;
    }
  }

  checkNotification() {
    for (Noti noti in notifications) {
      noti.isRead = true;
    }
    for (Noti noti in archiveNotifications) {
      noti.isRead = true;
    }
    _userRepository.setNotifications(notifications);
    _userRepository.setArchiveNotifications(archiveNotifications);
    notifyListeners();
  }

  int getNewNotificationNumber() {
    int count = 0;
    for (Noti noti in notifications) {
      if (!noti.isRead) {
        count++;
      }
    }
    return count;
  }

  addNotification(Noti noti) {
    print("add noti");
    notifications.insert(0, noti);
    _userRepository.setNotifications(notifications);
    notifyListeners();
  }

  addArchiveNotification(Noti noti) {
    print("add archive");
    archiveNotifications.insert(0, noti);
    _userRepository.setArchiveNotifications(archiveNotifications);
    notifyListeners();
  }

  removeNotification(int index) {
    print("remove noti");
    try {
      notifications.removeAt(index);
      _userRepository.setNotifications(notifications);
    } catch (e) {
      print("there is no item in notification at index $index");
    }
    notifyListeners();
  }

  removeArchiveNotification(int index) {
    print("remove archive");
    try {
      archiveNotifications.removeAt(index);
      _userRepository.setArchiveNotifications(archiveNotifications);
    } catch (e) {
      print("there's no item in archive notifications at index $index");
    }
    notifyListeners();
  }

  archive(int index) {
    print("archive");
    addArchiveNotification(notifications[index]);
    removeNotification(index);
    notifyListeners();
  }

  unArchive(int index) {
    print("unarchive");
    addNotification(archiveNotifications[index]);
    removeArchiveNotification(index);
    notifyListeners();
  }

  clear() {
    _me = null;
    _familyMembers = [];
  }
}
