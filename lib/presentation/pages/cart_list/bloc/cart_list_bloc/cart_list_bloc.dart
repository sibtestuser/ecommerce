import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../core/utils/error/error_response.dart';
import '../../../../../core/utils/exception/common_exception.dart';
import '../../../../../core/utils/logger.dart';
import '../../../../../domain/model/common/result.dart';
import '../../../../../domain/model/display/cart/cart.model.dart';
import '../../../../../domain/model/display/product_info/product_info.model.dart';
import '../../../../../domain/usecase/display/cart/cart_usecase.dart';
import '../../../../../domain/usecase/display/cart/get_cart_list.usecase.dart';
import '../../../../../domain/usecase/display/display.usecase.dart';

part 'cart_list_state.dart';
part 'cart_list_event.dart';
part 'cart_list_bloc.freezed.dart';

@injectable
class CartListBloc extends Bloc<CartListEvent, CartListState> {
  final DisplayUsecase _displayUsecase;

  CartListBloc(this._displayUsecase) : super(CartListState()) {
    on<CartListInitialized>(_onCartListInitialized);
    on<CartListAdded>(_onCartListAdded);
    on<CartListSelected>(_onCartSelected);
    on<CartListSelectedAll>(_onCartSelectedAll);
    on<CartListDeleted>(_onCartDeleted);
    on<CartListQtyDecreased>(_onCartQtyDecreased);
    on<CartListQtyIncreased>(_onCartQtyIncreased);
  }

  Future<void> _onCartListInitialized(CartListInitialized event, Emitter<CartListState> emit) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final response = await _displayUsecase.excute<Result<List<Cart>?>>(usecase: GetCartListUsecase());
      response.when(
        succes: (cartList) {
          final selectedProducts = cartList!.map((e) => e.product.productId).toList();
          final totalPrice = _calTotalPrice(selectedProducts, cartList);
          print('[test] total price = $totalPrice');
          emit(state.copyWith(
              status: Status.success, totalPrice: totalPrice, cartList: cartList, selectedProduct: selectedProducts));
        },
        failure: (error) {
          emit(
            state.copyWith(status: Status.error, errorResponse: error),
          );
        },
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(status: Status.error, errorResponse: CommonException.setError(error)));
    }
  }

  Future<void> _onCartListAdded(CartListAdded event, Emitter<CartListState> emit) async {
    emit(state.copyWith(status: Status.loading));
    final cart = Cart(product: event.productInfo, quantity: event.quantity);
    try {
      final response = await _displayUsecase.excute(usecase: AddCartListUsecase(cart));
      response.when(
        succes: (cartList) {
          final selectedProducts = [...state.selectedProduct];
          final productId = event.productInfo.productId;
          final int index = selectedProducts.indexWhere((element) => element == productId);
          if (index == -1) {
            selectedProducts.add(productId);
          }
          final totalPrice = _calTotalPrice(selectedProducts, cartList!);
          emit(
            state.copyWith(
                status: Status.success, cartList: cartList, selectedProduct: selectedProducts, totalPrice: totalPrice),
          );
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, errorResponse: error));
        },
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(status: Status.error, errorResponse: CommonException.setError(error)));
    }
  }

  Future<void> _onCartQtyIncreased(CartListQtyIncreased event, Emitter<CartListState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await _displayUsecase.excute<Result<List<Cart>?>>(
          usecase: ChangeCartQtyUsecase(event.cart.product.productId, event.cart.quantity + 1));
      response.when(
        succes: (cartList) {
          final totalPrice = _calTotalPrice(state.selectedProduct, cartList!);
          emit(state.copyWith(status: Status.success, totalPrice: totalPrice, cartList: cartList));
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, errorResponse: error));
        },
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(status: Status.error, errorResponse: CommonException.setError(error)));
    }
  }

  Future<void> _onCartQtyDecreased(CartListQtyDecreased event, Emitter<CartListState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      if (event.cart.quantity - 1 < 1) {
        emit(state.copyWith(status: Status.success));

        return;
      }
      final response = await _displayUsecase.excute<Result<List<Cart>?>>(
          usecase: ChangeCartQtyUsecase(event.cart.product.productId, event.cart.quantity - 1));
      response.when(
        succes: (cartList) {
          final totalPrice = _calTotalPrice(state.selectedProduct, cartList!);
          emit(state.copyWith(status: Status.success, totalPrice: totalPrice, cartList: cartList));
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, errorResponse: error));
        },
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(status: Status.error, errorResponse: CommonException.setError(error)));
    }
  }

  Future<void> _onCartDeleted(CartListDeleted event, Emitter<CartListState> emit) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final response = await _displayUsecase.excute<Result<List<Cart>?>>(usecase: DeleteCartUsecase(event.productIds));
      response.when(
        succes: (cartList) {
          final selectedProducts = cartList!.map((e) => e.product.productId).toList();
          final totalPrice = _calTotalPrice(state.selectedProduct, cartList);
          emit(state.copyWith(
              status: Status.success, selectedProduct: selectedProducts, totalPrice: totalPrice, cartList: cartList));
        },
        failure: (error) {
          emit(state.copyWith(status: Status.error, errorResponse: error));
        },
      );
    } catch (error) {
      CustomLogger.logger.e(error);
      emit(state.copyWith(status: Status.error, errorResponse: CommonException.setError(error)));
    }
  }

  void _onCartSelected(
    CartListSelected event,
    Emitter<CartListState> emit,
  ) {
    try {
      final String productId = event.cart.product.productId;
      final selectedProducts = [...state.selectedProduct];
      final int selectedIdx = state.selectedProduct.indexWhere((element) => element == productId);
      if (selectedIdx == -1) {
        selectedProducts.add(productId);
      } else {
        selectedProducts.removeAt(selectedIdx);
      }

      final totalPrice = _calTotalPrice(selectedProducts, state.cartList);

      emit(state.copyWith(
        selectedProduct: selectedProducts,
        totalPrice: totalPrice,
      ));
    } catch (error) {
      CustomLogger.logger.e('${error.toString()}');
      emit(state.copyWith(
        status: Status.error,
        errorResponse: CommonException.setError(error),
      ));
    }
  }

  void _onCartSelectedAll(
    CartListSelectedAll event,
    Emitter<CartListState> emit,
  ) {
    try {
      // 이미 전체 선택이 되어있는 경우 -> 모두 지움
      if (state.selectedProduct.length == state.cartList.length) {
        emit(state.copyWith(selectedProduct: [], totalPrice: 0));

        return;
      }

      final selectedProducts = state.cartList.map((e) => e.product.productId).toList();
      final totalPrice = _calTotalPrice(selectedProducts, state.cartList);

      emit(state.copyWith(
        selectedProduct: selectedProducts,
        totalPrice: totalPrice,
      ));
    } catch (error) {
      CustomLogger.logger.e('${error.toString()}');
      emit(state.copyWith(
        status: Status.error,
        errorResponse: CommonException.setError(error),
      ));
    }
  }

  int _calTotalPrice(List<String> selectedIds, List<Cart> carts) {
    int price = 0;

    for (final id in selectedIds) {
      for (final cart in carts) {
        if (id == cart.product.productId) {
          price += cart.product.price * cart.quantity;
        }
      }
    }
    return price;
  }
}
