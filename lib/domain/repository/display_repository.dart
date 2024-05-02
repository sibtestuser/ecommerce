import '../../data/dto/common/response_wrapper/response_wrapper.dart';
import '../../presentation/main/cubit/mall_type_cubic.dart';
import '../model/display/menu/menu.model.dart';
import '../model/display/view_module/view_module.model.dart';
import 'repository.dart';

abstract class DisplayRepository extends Repository {
  Future<ResponseWrapper<List<Menu>>> getMenusByMallType({required MallType mallType});

  Future<ResponseWrapper<List<ViewModule>>> getViewModuleByTabId({
    required int tabId,
  });
}
