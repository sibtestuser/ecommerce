import '../../domain/model/display/menu/menu.model.dart';
import '../../domain/model/display/view_module/view_module.model.dart';
import '../../domain/repository/display_repository.dart';
import '../../presentation/main/cubit/mall_type_cubic.dart';
import '../data_source/remote/display.api.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import '../dto/mapper/common.mapper.dart';
import '../dto/mapper/dispaly.mapper.dart';

class DisplayRepositoryImpl implements DisplayRepository {
  final DisplayApi _displayApi;
  DisplayRepositoryImpl(this._displayApi);
  @override
  Future<ResponseWrapper<List<Menu>>> getMenusByMallType({required MallType mallType}) async {
    final response = await _displayApi.getMenusByMallType(mallType.name);
    return response.toModel<List<Menu>>(response.data?.map((e) => e.toModel()).toList() ?? []);
  }

  Future<ResponseWrapper<List<ViewModule>>> getViewModuleByTabId({required int tabId}) async {
    final response = await _displayApi.getViewModulesByTabId(tabId);
    return response.toModel(response.data?.map((e) => e.toModel()).toList() ?? []);
  }
}
