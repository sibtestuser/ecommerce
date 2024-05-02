import 'dart:convert';
import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

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

  List<MenuDto> _menuParser(String source) {
    List<MenuDto> menus = [];
    final List json = jsonDecode(source);

    menus = json.map((e) => MenuDto.fromJson(e)).toList();
    return menus;
  }

  @override
  Future<ResponseWrapper<List<ViewModuleDto>>> getViewModulesByTabId(int tabId) {
    final endOfTabId = tabId % 10;
    late String source;
    switch (endOfTabId) {
      case 1:
        source = DisplayMockData.viewModulesByTabIdCaseOne;
      case 2:
        source = DisplayMockData.viewModulesByTabIdCaseTwo;
      case 3:
        source = DisplayMockData.viewModulesByTabIdCaseThree;
      case 4:
        source = DisplayMockData.viewModulesByTabIdCaseFour;
      case 5:
        source = DisplayMockData.viewModulesByTabIdCaseFive;
    }

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
}
