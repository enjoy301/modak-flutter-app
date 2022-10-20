import 'package:freezed_annotation/freezed_annotation.dart';

part 'fortune.freezed.dart';
part 'fortune.g.dart';

@unfreezed
class Fortune with _$Fortune {
  factory Fortune({required String type, required String content}) = _Fortune;

  factory Fortune.fromJson(Map<String, dynamic> json) =>
      _$FortuneFromJson(json);
}
