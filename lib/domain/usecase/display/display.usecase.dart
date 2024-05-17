import 'package:injectable/injectable.dart';

import '../../model/common/result.dart';
import '../../repository/display_repository.dart';
import '../base/remote.usecase.dart';
import '../base/usecase.dart';

//상위 usecase 하위 usecase는 menu
@singleton
class DisplayUsecase {
  final DisplayRepository _displayRepository;
  DisplayUsecase(this._displayRepository);
  Future<T> excute<T>({required Usecase usecase}) async {
    return await usecase(_displayRepository);
  }
}
