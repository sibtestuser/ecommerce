import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:retrofit/retrofit.dart';

import '../../dto/common/response_wrapper/response_wrapper.dart';
import '../../dto/display/menu/menu.dto.dart';
import '../../dto/display/view_module/view_module.dto.dart';

part 'display.api.g.dart';

@RestApi()
abstract class DisplayApi {
  factory DisplayApi(Dio dio, {String baseUrl}) = _DisplayApi;

  @GET('/api/menus/{mall_type}')
  Future<ResponseWrapper<List<MenuDto>>> getMenusByMallType(@Path('mall_type') String mallType);

  @GET('/api/view-modules/{tab_id}/{page}')
  Future<ResponseWrapper<List<ViewModuleDto>>> getViewModulesByTabId(
    @Path('tab_id') int tabId,
    @Path('page') int page,
  );
}
