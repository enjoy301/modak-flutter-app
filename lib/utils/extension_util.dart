import 'package:modak_flutter_app/constant/enum/general_enum.dart';

extension StringToType on String? {
  FamilyType? toFamilyType () {
    switch (this) {
      case "FamilyType.dad":
        return FamilyType.dad;
      case "FamilyType.mom":
        return FamilyType.mom;
      case "FamilyType.son":
        return FamilyType.son;
      case "FamilyType.dau":
        return FamilyType.dau;
      default:
        return null;
    }
  }
}
