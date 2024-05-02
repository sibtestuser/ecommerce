import '../../repository/repository.dart';

// 상위 usecase 야
//햐위에 excute 해
abstract class RemoteUsecase<T extends Repository> {
  Future call(T repository);
}
