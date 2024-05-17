import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../theme/custom/custom_font_weight.dart';
import '../theme/custom/custom_theme.dart';
import 'constant.dart';

extension StatusX on Status {
  bool get isInitial => this == Status.initial;
  bool get isLoading => this == Status.loading;
  bool get isSuccess => this == Status.success;
  bool get isError => this == Status.error;
}

extension StringX on String {
  String toSnakeCase() {
    RegExp exp = RegExp(r'(?<=[a-z])[A-Z]');

    return replaceAllMapped(exp, (Match m) => ('_${m.group(0)}')).toLowerCase();
  }

  bool get isSuccess => this == 'SUCCESS';
}

extension IntEX on int {
  String toWon() {
    final priceFormat = NumberFormat('###,###,###,###원');
    return priceFormat.format(this);
  }

  String toReview() {
    return this > 9999 ? '9999+' : toString();
  }
}

extension TextStyleX on TextStyle {
  TextStyle? titleCopywith() {
    return this
        .copyWith(
          color: CustomTheme.colorScheme.contentPrimary,
        )
        .regular;
  }

  TextStyle? discountCopywith() {
    return this
        .copyWith(
          color: CustomTheme.colorScheme.secondary,
        )
        .bold;
  }

  TextStyle? priceCopywith() {
    return this
        .copyWith(
          color: CustomTheme.colorScheme.contentPrimary,
        )
        .bold;
  }

  TextStyle? originalPriceCopywith() {
    return this
        .copyWith(
          color: CustomTheme.colorScheme.contentFourth,
          decoration: TextDecoration.lineThrough,
        )
        .regular;
  }

  TextStyle? reviewCountCopywith() {
    return this
        .copyWith(
          color: CustomTheme.colorScheme.contentTertiary,
        )
        .regular;
  }
}
