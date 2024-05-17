import '../../repository/repository.dart';
import 'usecase.dart';

// 상위 usecase 야
//햐위에 excute 해
abstract class LocalUsecase<T extends Repository> extends Usecase<T> {}
