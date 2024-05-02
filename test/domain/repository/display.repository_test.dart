import 'package:e_commerce_app/data/data_source/mock/diplay/display_mock_api.dart';
import 'package:e_commerce_app/data/data_source/remote/display.api.dart';
import 'package:e_commerce_app/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:e_commerce_app/data/dto/display/menu/menu.dto.dart';
import 'package:e_commerce_app/data/dto/mapper/common.mapper.dart';
import 'package:e_commerce_app/data/dto/mapper/dispaly.mapper.dart';
import 'package:e_commerce_app/data/ropository_impl/display.repository.impl.dart';
import 'package:e_commerce_app/domain/model/display/menu/menu.model.dart';
import 'package:e_commerce_app/domain/repository/display_repository.dart';
import 'package:e_commerce_app/presentation/main/cubit/mall_type_cubic.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockDisplayApi extends Mock implements DisplayApi {}

void main() {
  late DisplayRepository displayRepository;
  late DisplayApi displayApi;
  setUpAll(() {
    displayApi = MockDisplayApi();
    displayRepository = DisplayRepositoryImpl(displayApi);
  });

  test('의존성 주입 및 객체생성 완료', () => expect(displayRepository, isNotNull));

  group('메뉴리스트 불러오기', () {
    //api 호출 성공

    test('api 호출 완료', () async {
      try {
        final result = await displayRepository.getMenusByMallType(mallType: MallType.market);
        //  print(result);
      } catch (e) {}
      verify(() {
        return displayApi.getMenusByMallType(any());
      }).called(1);
    });

    test('api 호출 실패', () async {
      final exception = Exception('error');
      when(() => displayApi.getMenusByMallType(any())).thenThrow(exception);
      expect(() => displayRepository.getMenusByMallType(mallType: MallType.market), throwsA(exception));
    });

    test('api 호출 성공적', () async {
      final MallType mallType = MallType.market;
      final ResponseWrapper<List<MenuDto>> mockingData = await DisplayMockApi().getMenusByMallType(mallType.name);

      final actual = await DisplayRepositoryImpl(DisplayMockApi()).getMenusByMallType(mallType: MallType.market);

      when(() => displayApi.getMenusByMallType(any())).thenAnswer((invocation) async => mockingData);

      final expected = mockingData.toModel<List<Menu>>(mockingData.data?.map((e) => e.toModel()).toList() ?? []);

      expect(actual, expected);
    });
  });
}
