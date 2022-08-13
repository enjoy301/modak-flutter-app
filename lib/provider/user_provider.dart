import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/utils/extension_util.dart';
import 'package:modak_flutter_app/utils/prefs_util.dart';

class UserProvider extends ChangeNotifier {
  static int family_id = 1;
  static int user_id = 4;

  String? _name = PrefsUtil.getString("user_name");
  String? get name => _name;

  void setName(String name) {
    _name = name;
    PrefsUtil.setString("user_name", name);
  }

  int? _isLunar = PrefsUtil.getInt("user_is_lunar");
  int? get isLunar => _isLunar;

  void setIsLunar(int isLunar) {
    _isLunar = isLunar;
    PrefsUtil.setInt("user_is_lunar", isLunar);
  }

  DateTime? _birthDay = PrefsUtil.getString("user_birth_day") == null
      ? null
      : DateTime.tryParse(PrefsUtil.getString("user_birth_day")!);
  DateTime? get birthDay => _birthDay;

  void setBirthDay(DateTime birthDay) {
    _birthDay = birthDay;
    PrefsUtil.setString("user_birth_day", DateFormat("yyyy-MM-dd").format(birthDay));
  }

  String? _profileImageUrl = PrefsUtil.getString("user_profile_image_url");
  String? get profileImageUrl => _profileImageUrl;

  void setProfileImageUrl(String profileImageUrl) {
    _profileImageUrl = profileImageUrl;
    PrefsUtil.setString("user_profile_image_url", profileImageUrl);
  }

  FamilyType? _familyType = PrefsUtil.getString("user_family_type").toFamilyType();
  FamilyType? get familyType => _familyType;

  void setFamilyType(FamilyType familyType) {
    _familyType = familyType;
    PrefsUtil.setString("user_family_type", familyType.toString());
  }

  Color? _color = PrefsUtil.getString("user_color").toColor();
  Color? get color => _color;
  
  void setColor(Color color) {
    _color = color;
    PrefsUtil.setString("user_color", color.toString().substring(8,16));
  }

  List<String> _tags = PrefsUtil.getStringList("user_tags") ?? [];
  List<String> get tags => _tags;

  void setTags(List<String> tags) {
    _tags = tags;
    PrefsUtil.setStringList("user_tags", tags);
  }

  void addTag(String tag) {
    _tags.add(tag);
    PrefsUtil.setStringList("user_tags", _tags);
  }

  void removeTag(String tag) {
    _tags.remove(tag);
    PrefsUtil.setStringList("user_tags", _tags);
  }

  List<String> _familyMembers = PrefsUtil.getStringList("user_family_members") ?? [];
  List<String> get familyMembers => _familyMembers;

  void setFamilyMembers(List<String> familyMembers) {
    _familyMembers = familyMembers;
    PrefsUtil.setStringList("user_family_members", familyMembers);
  }

  void addFamilyMember(String familyMember) {
    _familyMembers.add(familyMember);
    PrefsUtil.setStringList("user_family_members", _familyMembers);
  }

  void removeFamilyMember(String familyMember) {
    _familyMembers.remove(familyMember);
    PrefsUtil.setStringList("user_family_members", _familyMembers);
  }

}

