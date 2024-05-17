import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import '../../../core/utils/exception/common_exception.dart';
import '../../../core/utils/logger.dart';
import '../../repository/user.repository.dart';
import '../base/remote.usecase.dart';

class LoginUsecase extends RemoteUsecase<UserRepository> {
  @override
  Future<User?> call(UserRepository repository) async {
    if (await isKakaoTalkInstalled()) {
      try {
        await UserApi.instance.loginWithKakaoTalk();
      } catch (error) {
        if (error is KakaoAuthException && (error.message?.contains('Cancelled') ?? false)) {
          return null;
          //매핑한다면
          //Result.fauilure(ErrorResponse())  가 되겠지.
        }

        await _loginWithKakaoAccount();
      }
    } else {
      await _loginWithKakaoAccount();
    }
// 여기도 user service 만든 다음에는 RESULT 값으로 매핑
    return UserApi.instance.me();
  }

  Future<void> _loginWithKakaoAccount() async {
    try {
      await UserApi.instance.loginWithKakaoAccount();
    } catch (error) {
      if (error is PlatformException && error.code == 'CANCELLED') {
        return null;
      }
      CustomLogger.logger.e('${error.toString()}');
      throw CommonException.setError(error);
    }
  }
}
