import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'core/theme/theme_data.dart';
import 'core/utils/exception/common_exception.dart';
import 'core/utils/logger.dart';
import 'data/data_source/mock/diplay/display_mock_api.dart';
import 'data/ropository_impl/display.repository.impl.dart';
import 'domain/repository/display_repository.dart';
import 'domain/usecase/display/display.usecase.dart';
import 'domain/usecase/display/menu/get_menus_usecase.dart';
import 'presentation/main/cubit/mall_type_cubic.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/splash/splash_page.dart';
import 'presentation/routes/routes.dart';
import 'service_locator.dart';

void main() async {
  //final data = await DisplayMockApi().getMenusByMallType('market');
  //final data = await DisplayRepositoryImpl(DisplayMockApi()).getMenusByMallType(mallType: MallType.market);
  //print(data);
  // 원래는
  // final menu = await DisplayUsecase(DisplayRepositoryImpl(DisplayMockApi()))
  //     .excute(usecase: GetMenusUsecase(mallType: MallType.market));
  // print(menu);
  setLocator();

  //final menus = await locator<DisplayUsecase>().excute(usecase: GetMenusUsecase(mallType: MallType.market));

  // print(menus);
  // try {
  //   final test = await DisplayMockApi().getMenusByMallType('market');
  //   CustomLogger.logger.d(test);
  // } catch (error) {
  //   final errorData = CommonException.setError(error);
  //   CustomLogger.logger.e(errorData);
  // }
  try {
    final test = await DisplayMockApi().getViewModulesByTabId(1001);
    CustomLogger.logger.d(test);
  } catch (error) {
    final errorData = CommonException.setError(error);
    CustomLogger.logger.e(errorData);
  }
  // print(test);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the  root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      theme: CustomThemeData.themeData,
    );
  }
}
