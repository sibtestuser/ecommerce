import '../../../../core/utils/error/error_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../../model/common/result.dart';
import '../../../repository/display_repository.dart';
import '../../base/local.usecase.dart';

class ChangeCartQtyUsecase extends LocalUsecase<DisplayRepository> {
  final String productId;
  final int qty;

  ChangeCartQtyUsecase(this.productId, this.qty);

  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.chanegeCartQuantityByPrdId(producId: productId, quantity: qty);
    return result.status.isSuccess
        ? Result.succes(result.data)
        : Result.failure(ErrorResponse(status: result.status, code: result.code, message: result.message));
  }
}
