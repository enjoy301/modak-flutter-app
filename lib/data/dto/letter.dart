import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';
import 'package:modak_flutter_app/constant/enum/general_enum.dart';

part 'letter.freezed.dart';
part 'letter.g.dart';

@unfreezed
class Letter with _$Letter {
  @HiveType(typeId: 22)
  factory Letter({
    @HiveField(0) required int fromMemberId,
    @HiveField(1) required int toMemberId,
    @HiveField(2) required String content,
    @HiveField(3) required EnvelopeType envelope,
    @HiveField(4) required String date,
  }) = _Letter;

  factory Letter.fromJson(Map<String, dynamic> json) => _$LetterFromJson(json);
}
