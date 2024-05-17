import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../../core/utils/exception/common_exception.dart';
import '../../../core/utils/logger.dart';
import '../../repository/user.repository.dart';
import '../base/remote.usecase.dart';

class LogoutUsecase extends RemoteUsecase<UserRepository> {
  @override
  Future<void> call(UserRepository repository) async {
    // TODO: implement call

    try {
      await UserApi.instance.logout();
    } catch (error) {
      CustomLogger.logger.e('${error.toString()}');
      throw CommonException.setError(error);
    }
  }
}
