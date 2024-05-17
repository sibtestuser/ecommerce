import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../../core/utils/exception/common_exception.dart';
import '../../../core/utils/logger.dart';
import '../../repository/repository.dart';
import '../../repository/user.repository.dart';
import '../base/remote.usecase.dart';

class LoginWithTokenUsecase extends RemoteUsecase<UserRepository> {
  @override
  Future<User?> call(Repository repository) async {
    // TODO: implement call
    //이전에 사용자가 로그인을 했고 토큰이 ㅏㅁ아 있다면 자동으로 로그인

    if (await AuthApi.instance.hasToken()) {
      //유효한 토큰인지 검사
      //완료된 상태인 경우 토큰을 갱신 (refresh)
      try {
        await UserApi.instance.accessTokenInfo();
      } catch (error) {
        CustomLogger.logger.e('${error.toString()}');
        throw CommonException.setError(error);
      }
    } else {
      return null;
    }

    return await UserApi.instance.me();
  }
}
