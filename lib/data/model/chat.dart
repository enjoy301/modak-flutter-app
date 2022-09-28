import 'package:freezed_annotation/freezed_annotation.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@unfreezed
class Chat with _$Chat {
  factory Chat({
    required int userId,
    required String content,
    required double sendAt,
    required Map? metaData,
    required int unReadCount,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
}
