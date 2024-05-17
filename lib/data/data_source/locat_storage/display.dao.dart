import 'package:hive/hive.dart';

import '../../dto/common/response_wrapper/response_wrapper.dart';
import '../../entity/cart/cart.entity.dart';

const String _cartDb = 'Cart_DB';

class DisplayDao {
  //장바구니 list 불러오기

  Future<ResponseWrapper<List<CartEntity>>> getCartList() async {
    final localStorage = await Hive.openBox<CartEntity>(_cartDb);

    return ResponseWrapper(
      status: 'SUCCESS',
      code: '0000',
      message: '성공적으로 장바구니를 불러왔습니다.',
      data: localStorage.values.toList(),
    );
  }

//장바구니 담기
  Future<ResponseWrapper<List<CartEntity>>> insertCart(CartEntity cart) async {
    final localStorage = await Hive.openBox<CartEntity>(_cartDb);

    final productId = cart.product.productId;

    if (localStorage.get(productId) != null) {
      final status = '이미 존재하는 상품 ::: ${cart.product.productId}';
      final code = 'Cart-1000';
      final message = '이미 장바구니에 존재하는 상품입니다';
      return ResponseWrapper(
        status: status,
        code: code,
        message: message,
        data: localStorage.values.toList(),
      );
    }

    await localStorage.put(productId, cart);

    return ResponseWrapper(
      status: 'SUCCESS',
      code: '0000',
      message: '성공적으로 장바구니에 저장했습니다.',
      data: localStorage.values.toList(),
    );
  }

  // 장바구니 담긴 상품 삭제

  Future<ResponseWrapper<List<CartEntity>>> deleteCart(List<String> productIds) async {
    final localStorage = await Hive.openBox<CartEntity>(_cartDb);

    await localStorage.deleteAll(productIds);

    return ResponseWrapper(
      status: 'SUCCESS',
      code: '0000',
      message: '성공적으로 ${productIds}상품을 장바구니에서 삭제하였습니다.',
      data: localStorage.values.toList(),
    );
  }

  // 장바구니 전체 삭제

  Future<ResponseWrapper<List<CartEntity>>> clearCart() async {
    final localStorage = await Hive.openBox<CartEntity>(_cartDb);

    await localStorage.clear();

    return ResponseWrapper(
      status: 'SUCCESS',
      code: '0000',
      message: '성공적으로 상품을 장바구니에서 모두 삭제하였습니다.',
      data: localStorage.values.toList(),
    );
  }

  //장바구니 수량 변경

  Future<ResponseWrapper<List<CartEntity>>> changeQtyCart(String productId, int quantity) async {
    final localStorage = await Hive.openBox<CartEntity>(_cartDb);

    final currentCart = localStorage.get(productId);
    if (currentCart == null) {
      final status = '장바구니 객체가 존재하지 않습니다  ';
      final code = 'Cart-1001';
      final message = '네트워크 오류가 발생했습니다. 잠시 후에 다시 시도해 주세요';
      return ResponseWrapper(
        status: status,
        code: code,
        message: message,
        data: localStorage.values.toList(),
      );
    }
    final nextCart = CartEntity(product: currentCart.product, quantity: quantity);
    await localStorage.put(productId, nextCart);

    return ResponseWrapper(
      status: 'SUCCESS',
      code: '0000',
      message: '성공적으로 ${nextCart.product.title} 수량을 변경했습니다.',
      data: localStorage.values.toList(),
    );
  }
}
