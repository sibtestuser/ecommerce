part of 'cart_bloc.dart';

abstract class CartEvent {
  CartEvent();
}

class CartInitialized extends CartEvent {
  CartInitialized();
}

class CartClosed extends CartEvent {
  CartClosed();
}

class CartOpend extends CartEvent {
  final ProductInfo productInfo;
  final int quantity;
  CartOpend(this.productInfo, {this.quantity = 1});
}

class CartQuantityIncreased extends CartEvent {
  CartQuantityIncreased();
}

class CartQuantityDecreased extends CartEvent {
  CartQuantityDecreased();
}
