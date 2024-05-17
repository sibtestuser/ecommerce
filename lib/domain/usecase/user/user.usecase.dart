//상위 usecase 하위 usecase는 menu
import 'package:injectable/injectable.dart';

import '../../repository/user.repository.dart';
import '../base/usecase.dart';

@singleton
class UserUsecase {
  final UserRepository _userRepository;
  UserUsecase(this._userRepository);
  Future<T> excute<T>({required Usecase usecase}) async {
    return await usecase(_userRepository);
  }
}
