import 'package:injectable/injectable.dart';

import '../../domain/model/display/cart/cart.model.dart';
import '../../domain/model/display/menu/menu.model.dart';
import '../../domain/model/display/view_module/view_module.model.dart';
import '../../domain/repository/display_repository.dart';
import '../../presentation/main/cubit/mall_type_cubic.dart';
import '../data_source/locat_storage/display.dao.dart';
import '../data_source/remote/display.api.dart';
import '../dto/common/response_wrapper/response_wrapper.dart';
import '../dto/mapper/common.mapper.dart';
import '../dto/mapper/dispaly.mapper.dart';

@Singleton(as: DisplayRepository)
class DisplayRepositoryImpl implements DisplayRepository {
  final DisplayApi _displayApi;
  final DisplayDao _displayDao;
  DisplayRepositoryImpl(this._displayApi, this._displayDao);
  @override
  Future<ResponseWrapper<List<Menu>>> getMenusByMallType({required MallType mallType}) async {
    final response = await _displayApi.getMenusByMallType(mallType.name);

    return response.toModel<List<Menu>>(response.data?.map((e) => e.toModel()).toList() ?? []);
  }

  Future<ResponseWrapper<List<ViewModule>>> getViewModuleByTabId({required int tabId, required int page}) async {
    final response = await _displayApi.getViewModulesByTabId(tabId, page);

    return response.toModel(response.data?.map((e) => e.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<Cart>>> addCartList({required Cart cart}) async {
    final response = await _displayDao.insertCart(cart.toEntity());
    return response.toModel<List<Cart>>(response.data?.map((CartEntity) => CartEntity.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<Cart>>> chanegeCartQuantityByPrdId(
      {required String producId, required int quantity}) async {
    final response = await _displayDao.changeQtyCart(producId, quantity);
    return response.toModel<List<Cart>>(response.data?.map((CartEntity) => CartEntity.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<Cart>>> clearCartList() async {
    final response = await _displayDao.clearCart();
    return response.toModel<List<Cart>>(response.data?.map((CartEntity) => CartEntity.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<Cart>>> deleteCartByProductId(List<String> productIds) async {
    final response = await _displayDao.deleteCart(productIds);

    return response.toModel<List<Cart>>(response.data?.map((CartEntity) => CartEntity.toModel()).toList() ?? []);
  }

  @override
  Future<ResponseWrapper<List<Cart>>> getCartList() async {
    final response = await _displayDao.getCartList();
    return response.toModel<List<Cart>>(response.data?.map((CartEntity) => CartEntity.toModel()).toList() ?? []);
  }
}
