import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../product_info/product_info.model.dart';

part 'cart.model.freezed.dart';
part 'cart.model.g.dart';

@freezed
class Cart with _$Cart {
  const factory Cart({
    required ProductInfo product,
    required int quantity,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);
}
