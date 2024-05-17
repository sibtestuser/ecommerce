import '../../../../core/utils/error/error_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../../model/common/result.dart';
import '../../../model/display/cart/cart.model.dart';
import '../../../repository/display_repository.dart';
import '../../base/local.usecase.dart';

class AddCartListUsecase extends LocalUsecase<DisplayRepository> {
  final Cart cart;

  AddCartListUsecase(this.cart);
  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.addCartList(cart: cart);
    return result.status.isSuccess
        ? Result.succes(result.data)
        : Result.failure(ErrorResponse(status: result.status, code: result.code, message: result.message));
  }
}
