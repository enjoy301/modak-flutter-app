import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'chat_paging_DTO.freezed.dart';
part 'chat_paging_DTO.g.dart';

@unfreezed
class ChatPagingDTO with _$ChatPagingDTO {
  @HiveType(typeId: 30)
  factory ChatPagingDTO({
    @HiveField(0) required int count,
    @HiveField(1) required int lastId,
  }) = _ChatPagingDTO;
}
