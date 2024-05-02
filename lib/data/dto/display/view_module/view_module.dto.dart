import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'view_module.dto.freezed.dart';
part 'view_module.dto.g.dart';

@freezed
class ViewModuleDto with _$ViewModuleDto {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory ViewModuleDto({
    @Default('') String type,
    @Default('') String title,
    @Default('') String subtitle,
    @Default('') String imgUrl,
  }) = _ViewModuleDto;

  factory ViewModuleDto.fromJson(Map<String, dynamic> json) => _$ViewModuleDtoFromJson(json);
}
