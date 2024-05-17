import 'dart:convert';

import '../../../dto/common/response_wrapper/response_wrapper.dart';
import '../../../dto/display/menu/menu.dto.dart';
import '../../../dto/display/view_module/view_module.dto.dart';
import '../../remote/display.api.dart';
import 'display_mock.data.dart';

class DisplayMockApi implements DisplayApi {
  //Todo : implement getMenuByMallType
  @override
  Future<ResponseWrapper<List<MenuDto>>> getMenusByMallType(String mallType) {
    //throw SocketException('exception_test');
    return Future(
      () => ResponseWrapper(
        status: 'SUCCESS',
        // status: 'fail',
        code: '0000',
        message: '',
        data: _menuParser(mallType == 'market' ? DisplayMockData.menusByMarket : DisplayMockData.menusByBeauty),
      ),
    );
  }

  @override
  Future<ResponseWrapper<List<ViewModuleDto>>> getViewModulesByTabId(int tabId, int page) {
    if (page == 4) {
      return Future(() => ResponseWrapper(
            status: 'SUCCESS',
            code: '0000',
            message: '',
            data: [],
          ));
    }
    String source = DisplayMockData.getViewModules();

    return Future(() => ResponseWrapper(
          status: 'SUCCESS',
          code: '0000',
          message: '',
          data: _viewModuleParser(source),
        ));
  }

  List<ViewModuleDto> _viewModuleParser(String source) {
    List<ViewModuleDto> viewModules = [];
    final List json = jsonDecode(source);

    viewModules = json.map((e) => ViewModuleDto.fromJson(e)).toList();

    return viewModules;
  }

  List<MenuDto> _menuParser(String source) {
    List<MenuDto> menus = [];
    final List json = jsonDecode(source);

    menus = json.map((e) => MenuDto.fromJson(e)).toList();

    return menus;
  }
}
