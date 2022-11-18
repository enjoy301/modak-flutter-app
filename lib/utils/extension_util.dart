import 'dart:io';

import 'package:flutter/material.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';
import 'package:modak_flutter_app/constant/strings.dart';

extension StringConverter on String? {
  String toDisplayString() {
    switch (this) {
      case Strings.dad:
        return "아빠";
      case Strings.mom:
        return "엄마";
      case Strings.dau:
        return "딸";
      case Strings.son:
        return "아들";
      default:
        return "Error";
    }
  }
}

extension StringToTypeCertain on String {
  NotificationType toNotificationType() {
    return NotificationType.values
        .firstWhere((element) => this == element.toString().substring(0, element.toString().length));
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

  EnvelopeType? toEnvelopeType() {
    return EnvelopeType.values.firstWhere((e) => e.toString() == this);
  }

  String? mediaType() {
    if (this == null) {
      return null;
    }

    RegExp regExp = RegExp(r'png|mp4|jpg|jpeg|mov');
    String res = this!.toLowerCase().split(".").last;
    List<String> extensions = regExp.allMatches(res).map((m) => m.group(0).toString()).toList();
    if (extensions.contains("png")) {
      return "png";
    } else if (extensions.contains("mp4")) {
      return "mp4";
    } else if (extensions.contains("jpg")) {
      return "jpg";
    } else if (extensions.contains("jpeg")) {
      return "jpeg";
    } else if (extensions.contains("mov")) {
      return "mov";
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

extension ColorToString on Color {
  String colorToString() {
    return toString().substring(8, 16);
  }
}

extension MediaValidation on File {
  bool isImage() {
    File file = this;
    String path = file.path.toLowerCase();
    if (path.endsWith("png") || path.endsWith("jpg") || path.endsWith("jpg")) {
      return true;
    }
    if (path.endsWith("mp4") || path.endsWith("mov")) {
      return false;
    }
    return false;
  }

  bool isVideo() {
    return !isImage();
  }
}
