import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'menu.model.freezed.dart';
part 'menu.model.g.dart';

@freezed
class Menu with _$Menu {
  @JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
  const factory Menu({
    required int tabId,
    required String title,
  }) = _Menu;

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}
