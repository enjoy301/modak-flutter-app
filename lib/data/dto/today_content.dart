import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'today_content.freezed.dart';
part 'today_content.g.dart';

@unfreezed
class TodayContent with _$TodayContent {
  @HiveType(typeId: 50)
  factory TodayContent({
    @HiveField(0) required int id,
    @HiveField(1) required String type,
    @HiveField(2) required String title,
    @HiveField(3) required String desc,
    @HiveField(4) required String url,
  }) = _TodayContent;

  factory TodayContent.fromJson(Map<String, dynamic> json) =>
      _$TodayContentFromJson(json);
}
