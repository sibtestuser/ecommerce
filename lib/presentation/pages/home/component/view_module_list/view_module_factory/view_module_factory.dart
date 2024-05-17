import 'package:flutter/material.dart';

import '../../../../../../core/utils/extensions.dart';
import '../../../../../../domain/model/display/view_module/view_module.model.dart';
import '../banner.view_module.dart';
import '../brand_product.view_module.dart';
import '../carousel.view_module.dart';
import '../category_product.view_module.dart';
import '../scroll.view_module.dart';
import '../view_module_A.dart';
import '../view_module_B.dart';
import '../view_module_C.dart';
import '../view_module_D.dart';
import '../view_module_E.dart';
import '../view_module_none.dart';
import 'special_price.view_module.dart';

enum Modules {
  viewModuleA,
  viewModuleB,
  viewModuleC,
  viewModuleD,
  viewModuleE,
  carouselViewModule,
  bannerViewModule,
  scrollViewModule,
  specialPriceViewModule,
  categoryProductViewModule,
  brandProductViewModule,
}

class ViewModuleFactory {
  Widget textToWidget(ViewModule viewModule) {
    final String type = viewModule.type.toSnakeCase();
    for (final module in Modules.values) {
      final String name = module.name.toSnakeCase();
      if (name.contains(type)) {
        return module.toWidget(viewModule) as Widget;
      }
    }
    return const ViewModuleNone();
  }
}

extension ModulesX on Modules {
  Widget toWidget(ViewModule info) {
    switch (this) {
      case Modules.viewModuleA:
        return const ViewModuleA();
      case Modules.viewModuleB:
        return const ViewModuleB();
      case Modules.viewModuleC:
        return const ViewModuleC();
      case Modules.viewModuleD:
        return const ViewModuleD();
      case Modules.viewModuleE:
        return const ViewModuleE();
      case Modules.carouselViewModule:
        return CarouselViewModule(info: info);
      case Modules.bannerViewModule:
        return BannerViewModule(info: info);
      case Modules.scrollViewModule:
        return ScrollViewModule(info: info);
      case Modules.specialPriceViewModule:
        return SpecialPriceViewModule(info: info);
      case Modules.categoryProductViewModule:
        return CategoryProduct(info: info);
      case Modules.brandProductViewModule:
        return BrandProductViewModule(info: info);
    }
  }
}
