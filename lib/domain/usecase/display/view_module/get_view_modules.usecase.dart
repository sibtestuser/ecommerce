import '../../../../core/utils/error/error_response.dart';

import '../../../model/common/result.dart';
import '../../../model/display/view_module/view_module.model.dart';
import '../../../repository/display_repository.dart';
import '../../base/remote.usecase.dart';

class GetViewModulesUsecase extends RemoteUsecase<DisplayRepository> {
  final int tabId;
  GetViewModulesUsecase({required this.tabId});

  @override
  Future<Result<List<ViewModule>>> call(DisplayRepository repository) async {
    final result = await repository.getViewModuleByTabId(tabId: tabId);

    return (result.status == 'SUCCESS')
        ? Result.succes(result.data ?? [])
        : Result.failure(ErrorResponse(status: result.status, code: result.code, message: result.message));
  }
}
