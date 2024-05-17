import '../../../domain/model/display/cart/cart.model.dart';
import '../../../domain/model/display/menu/menu.model.dart';
import '../../../domain/model/display/product_info/product_info.model.dart';
import '../../../domain/model/display/view_module/view_module.model.dart';
import '../../entity/cart/cart.entity.dart';
import '../../entity/product_info/product_info.entity.dart';
import '../display/product_info/product_info.dto.dart';
import '../display/menu/menu.dto.dart';
import '../display/view_module/view_module.dto.dart';

//dto 를 extension 으로 해서 만드는 구나..

extension MenuX on MenuDto {
  Menu toModel() {
    return Menu(tabId: tabId ?? -1, title: title ?? '');
  }
}

extension ViewModuleX on ViewModuleDto {
  ViewModule toModel() {
    return ViewModule(
      type: type ?? '',
      title: title ?? '',
      subTitle: subtitle ?? '',
      imageUrl: imageUrl ?? '',
      time: time ?? -1,
      products: products.map((e) => e.toModel()).toList(),
      tabs: tabs,
    );
  }
}

extension ProductInfoX on ProductInfoDto {
  ProductInfo toModel() {
    return ProductInfo(
      productId: productId ?? '',
      title: title ?? '',
      subTitle: subtitle ?? '',
      imageUrl: imageUrl ?? '',
      price: price ?? -1,
      originalPrice: originalPrice ?? -1,
      discountRate: discountRate ?? -1,
      reviewCount: reviewCount ?? -1,
    );
  }
}

/// MODEL -> ENTITY
extension ProductInfoEx on ProductInfo {
  ProductInfoEntity toEntity() {
    return ProductInfoEntity(
      productId: productId,
      title: title,
      subtitle: subTitle,
      imageUrl: imageUrl,
      price: price,
      originalPrice: originalPrice,
      discountRate: discountRate,
      reviewCount: reviewCount,
    );
  }
}

/// Entity -> MODEL
extension ProductInfoEntityEx on ProductInfoEntity {
  ProductInfo toModel() {
    return ProductInfo(
      productId: productId,
      title: title,
      subTitle: subtitle,
      imageUrl: imageUrl,
      price: price,
      originalPrice: originalPrice,
      discountRate: discountRate,
      reviewCount: reviewCount,
    );
  }
}

extension CartEntityX on CartEntity {
  Cart toModel() {
    return Cart(product: product.toModel(), quantity: quantity);
  }
}

extension CartEx on Cart {
  CartEntity toEntity() {
    return CartEntity(product: product.toEntity(), quantity: quantity);
  }
}
