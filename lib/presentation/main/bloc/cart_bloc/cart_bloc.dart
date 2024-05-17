import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../core/utils/error/error_response.dart';
import '../../../../core/utils/exception/common_exception.dart';
import '../../../../core/utils/logger.dart';
import '../../../../domain/model/display/product_info/product_info.model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:bloc/bloc.dart';

import '../../../../domain/model/display/product_info/product_info.model.dart';
part 'cart_event.dart';
part 'cart_state.dart';
part 'cart_bloc.freezed.dart';

@injectable
class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState()) {
    on<CartInitialized>(_onCartInitialized);
    on<CartOpend>(_onCartOpened);
    on<CartClosed>(_onCartClosed);
    on<CartQuantityDecreased>(_onCartQuantityDecreased);
    on<CartQuantityIncreased>(_onCartQuantityIncreased);
  }

  void _onCartInitialized(CartInitialized event, Emitter<CartState> emit) {}

  void _onCartOpened(CartOpend event, Emitter<CartState> emit) {
    //bottom view 가 올라왔을때 상태
    if (state.status.isOpened) return;

    final productInfo = event.productInfo;
    final quantity = event.quantity;
    final totalPrice = productInfo.price * quantity;
    try {
      emit(state.copyWith(
        status: CartStatus.open,
        productInfo: productInfo,
        quantity: quantity,
        totlaPrice: totalPrice,
      ));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(
        status: CartStatus.error,
        error: CommonException.setError(error),
      ));
    }
  }

  void _onCartClosed(CartClosed event, Emitter<CartState> emit) {
    if (state.status.isClosed) return;
    try {
      emit(state.copyWith(status: CartStatus.close));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(
        status: CartStatus.error,
        error: CommonException.setError(error),
      ));
    }
  }

  void _onCartQuantityIncreased(CartQuantityIncreased event, Emitter<CartState> emit) {
    try {
      final quantity = state.quantity + 1;
      final totalPrice = quantity * state.productInfo.price;
      if (quantity >= 9999) return;
      emit(state.copyWith(quantity: quantity, totlaPrice: totalPrice));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(
        status: CartStatus.error,
        error: CommonException.setError(error),
      ));
    }
  }

  void _onCartQuantityDecreased(CartQuantityDecreased event, Emitter<CartState> emit) {
    try {
      final quantity = state.quantity - 1;
      final totalPrice = quantity * state.productInfo.price;
      if (quantity <= 0) return;
      emit(state.copyWith(quantity: quantity, totlaPrice: totalPrice));
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(
        status: CartStatus.error,
        error: CommonException.setError(error),
      ));
    }
  }

  @override
  void onChange(Change<CartState> change) {
    // TODO: implement onChange
    super.onChange(change);
    print('[test] chane :${change.currentState.status} --> ${change.nextState.status} ');
  }
}

extension CartStatusX on CartStatus {
  bool get isClosed => this == CartStatus.close;
  bool get isOpened => this == CartStatus.open;
  bool get isError => this == CartStatus.error;
}
