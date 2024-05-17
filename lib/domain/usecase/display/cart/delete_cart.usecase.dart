import '../../../../core/utils/error/error_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../../model/common/result.dart';
import '../../../repository/display_repository.dart';
import '../../base/local.usecase.dart';

class DeleteCartUsecase extends LocalUsecase<DisplayRepository> {
  final List<String> productsId;

  DeleteCartUsecase(this.productsId);
  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.deleteCartByProductId(productsId);

    return result.status.isSuccess
        ? Result.succes(result.data)
        : Result.failure(ErrorResponse(status: result.status, code: result.code, message: result.message));
  }
}
