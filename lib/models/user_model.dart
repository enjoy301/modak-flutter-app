import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  factory UserModel({
    required String? name,
    required String? birthDay,
    required bool? isLunar,
    required FamilyType? role,
    required String? fcmToken,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
