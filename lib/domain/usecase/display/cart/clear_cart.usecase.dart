import '../../../../core/utils/error/error_response.dart';
import '../../../../core/utils/extensions.dart';
import '../../../model/common/result.dart';
import '../../../repository/display_repository.dart';
import '../../../repository/repository.dart';
import '../../base/local.usecase.dart';
import '../display.usecase.dart';

class ClearCartListUsecase extends LocalUsecase<DisplayRepository> {
  @override
  Future call(DisplayRepository repository) async {
    final result = await repository.clearCartList();

    return result.status.isSuccess
        ? Result.succes(result.data)
        : Result.failure(ErrorResponse(status: result.status, code: result.code, message: result.message));
  }
}
