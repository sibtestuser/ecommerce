import '../../repository/display_repository.dart';
import '../base/remote.usecase.dart';

//상위 usecase 하위 usecase는 menu

class DisplayUsecase {
  final DisplayRepository _displayRepository;
  DisplayUsecase(this._displayRepository);
  Future excute<T>({required RemoteUsecase usecase}) async {
    return await usecase(_displayRepository);
  }
}
