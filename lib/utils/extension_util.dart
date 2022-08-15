import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';

extension FamilyTypeToView on FamilyType? {
  String? toDisplayString() {
    switch (this) {
      case FamilyType.dad:
        return "아빠";
      case FamilyType.mom:
        return "엄마";
      case FamilyType.dau:
        return "딸";
      case FamilyType.son:
        return "아들";
      default: return null;
    }
  }
}

extension StringToType on String? {
  FamilyType? toFamilyType() {
    switch (this) {
      case "FamilyType.dad":
        return FamilyType.dad;
      case "DAD":
        return FamilyType.dad;

      case "FamilyType.mom":
        return FamilyType.mom;
      case "MOM":
        return FamilyType.mom;

      case "FamilyType.son":
        return FamilyType.son;
      case "SON":
        return FamilyType.son;

      case "FamilyType.dau":
        return FamilyType.dau;
      case "DAU":
        return FamilyType.dau;

      default:
        return null;
    }
  }

  String? mediaType() {
    if (this == null) return null;
    RegExp regExp = RegExp(r'png|mp4|jpg');
    String res = this!.toLowerCase().split(".").last;
    List<String> extensions =
        regExp.allMatches(res).map((m) => m.group(0).toString()).toList();
    if (extensions.contains("png")) {
      return "png";
    } else if (extensions.contains("mp4")) {
      return "mp4";
    } else if (extensions.contains("jpg")) {
      return "jpg";
    }
    return null;
  }

  Color? toColor() {
    if (this == null) return null;
    var hexColor = this!.replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF$hexColor";
    }
    if (hexColor.length == 8) {
      return Color(int.parse("0x$hexColor"));
    }
    return null;
  }
}
