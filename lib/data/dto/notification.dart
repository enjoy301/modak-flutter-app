import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'notification.freezed.dart';
part 'notification.g.dart';

@unfreezed
class Noti with _$Noti {
  @HiveType(typeId: 32)
  factory Noti({
    @HiveField(0) required String notiType,
    @HiveField(1) required String title,
    @HiveField(2) required String des,
    @HiveField(3) required bool isRead,
    @HiveField(4) required Map metaData,
  }) = _Noti;

  factory Noti.fromJson(Map<String, dynamic> json) => _$NotiFromJson(json);
}
