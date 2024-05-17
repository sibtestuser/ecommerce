import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../core/theme/constant/app_colors.dart';
import '../../../../../../core/theme/constant/app_icons.dart';
import '../../../../../../core/theme/custom/custom_theme.dart';
import '../../../../../../core/utils/extensions.dart';
import '../../../../../../domain/model/display/product_info/product_info.model.dart';
import 'add_cart_button.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductInfo productInfo;
  final double imageAspect;
  final TextStyle? titleStyle;
  final TextStyle? priceStyle;
  final TextStyle? originalPriceStyle;
  final TextStyle? reviewStyle;
  final bool needShowReviewCount;

  const ProductCardWidget({
    super.key,
    required this.productInfo,
    required this.imageAspect,
    required this.needShowReviewCount,
    this.titleStyle,
    this.priceStyle,
    this.originalPriceStyle,
    this.reviewStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: imageAspect,
              child: Image.network(
                productInfo.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            AddCartButton(productInfo),
          ],
        ),
        SizedBox(
          height: 9,
        ),
        Text(
          productInfo.title,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
          style: titleStyle?.titleCopywith(),
        ),
        SizedBox(
          height: 1,
        ),
        Row(
          children: [
            Text(
              '${productInfo.discountRate} %',
              style: priceStyle?.discountCopywith(),
            ),
            SizedBox(
              width: 4,
            ),
            Text(
              productInfo.price.toWon(),
              style: priceStyle?.priceCopywith(),
            ),
          ],
        ),
        SizedBox(
          height: 4,
        ),
        Text(
          productInfo.originalPrice.toWon(),
          style: originalPriceStyle?.originalPriceCopywith(),
        ),
        SizedBox(
          height: 2,
        ),
        if (needShowReviewCount)
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppIcons.chat,
                  width: 13,
                  height: 13,
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.contentTertiary, BlendMode.srcIn),
                ),
                SizedBox(
                  width: 4,
                ),
                Text(
                  '후기 :' + productInfo.reviewCount.toReview(),
                  style: reviewStyle?.reviewCountCopywith(),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
