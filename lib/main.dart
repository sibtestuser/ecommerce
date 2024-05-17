import 'package:e_commerce_app/data/entity/product_info/product_info.entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';

import 'core/theme/theme_data.dart';
import 'core/utils/exception/common_exception.dart';
import 'core/utils/logger.dart';
import 'data/data_source/mock/diplay/display_mock_api.dart';
import 'data/entity/cart/cart.entity.dart';
import 'data/ropository_impl/display.repository.impl.dart';
import 'dependency_injection.config.dart';
import 'dependency_injection.dart';
import 'domain/repository/display_repository.dart';
import 'domain/usecase/display/display.usecase.dart';
import 'domain/usecase/display/menu/get_menus_usecase.dart';
import 'presentation/main/bloc/cart_bloc/cart_bloc.dart';
import 'presentation/main/bloc/user_bloc/user_bloc.dart';
import 'presentation/main/cubit/mall_type_cubic.dart';
import 'presentation/pages/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
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
  // setLocator();

  //final menus = await locator<DisplayUsecase>().excute(usecase: GetMenusUsecase(mallType: MallType.market));

  // print(menus);
  // try {
  //   final test = await DisplayMockApi().getMenusByMallType('market');
  //   CustomLogger.logger.d(test);
  // } catch (error) {
  //   final errorData = CommonException.setError(error);
  //   CustomLogger.logger.e(errorData);
  // }
  // try {
  //   final test = await DisplayMockApi().getViewModulesByTabId(1001);
  //   CustomLogger.logger.d(test);
  // } catch (error) {
  //   final errorData = CommonException.setError(error);
  //   CustomLogger.logger.e(errorData);
  // }
  // print(test);

  //hive 패키지 초기화

  await Hive.initFlutter();
// generate 해서 생긴 어댑터를 이족에서
  Hive.registerAdapter(ProductInfoEntityAdapter());
  Hive.registerAdapter(CartEntityAdapter());
  configureDependencies();
  KakaoSdk.init(
    nativeAppKey: '6fcbd75f32e8c368edbed256f49e1d1e',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the  root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<CartBloc>()..add(CartInitialized())),
        BlocProvider(lazy: false, create: (_) => getIt<CartListBloc>()..add(CartListInitialized())),
        BlocProvider(create: (_) => getIt<UserBloc>()..add(UserLoginWithToken())),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        theme: CustomThemeData.themeData,
      ),
    );
  }
}
