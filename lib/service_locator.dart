import 'package:get_it/get_it.dart';

import 'data/data_source/mock/diplay/display_mock_api.dart';
import 'data/data_source/remote/display.api.dart';
import 'data/ropository_impl/display.repository.impl.dart';
import 'domain/repository/display_repository.dart';
import 'domain/repository/repository.dart';
import 'domain/usecase/display/display.usecase.dart';

final locator = GetIt.instance;

void setLocator() {
  _data();
  _domain();
}

void _data() {
  locator.registerSingleton<DisplayApi>(DisplayMockApi());
}

void _domain() {
  locator.registerSingleton<DisplayRepository>(DisplayRepositoryImpl(locator<DisplayApi>()));

  locator.registerSingleton<DisplayUsecase>(DisplayUsecase(locator<DisplayRepository>()));
}
