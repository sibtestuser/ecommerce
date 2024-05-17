import 'package:flutter/material.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../domain/model/display/product_info/product_info.model.dart';
import '../../../../../domain/model/display/view_module/view_module.model.dart';
import 'view_module_factory/view_module_widget.dart';
import 'widget/product_card.component.dart';
import 'widget/product_card_widget.dart';
import 'widget/view_module_padding.dart';
import 'widget/view_module_subtitle.dart';
import 'widget/view_module_title.dart';

class ScrollViewModule extends StatelessWidget with ViewModuleWidget {
  final ViewModule info;
  const ScrollViewModule({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ViewModulePadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ViewModuleTitle(title: info.title),
              if (info.subTitle.isNotEmpty) ViewModuleSubtitle(subtitle: info.subTitle),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: 10,
            bottom: 50,
          ),
          child: _ImageList(
            products: info.products,
          ),
        ),
      ],
    );
  }
}

class _ImageList extends StatelessWidget {
  final List<ProductInfo> products;
  const _ImageList({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 375 / 305,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: Constants.horizontalPadding,
        itemBuilder: (context, index) {
          final productInfo = products[index];
          return AspectRatio(
            aspectRatio: 150 / 305,
            child: LargeProductCard(context: context, productInfo: productInfo),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(
          width: 8,
        ),
        itemCount: products.length,
      ),
    );
  }
}
