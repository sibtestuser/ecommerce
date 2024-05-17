import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/constant/app_icons.dart';
import '../../../core/theme/custom/custom_font_weight.dart';
import '../../../core/theme/custom/custom_theme.dart';
import '../../../core/utils/constant.dart';
import '../../../core/utils/extensions.dart';
import '../../../dependency_injection.dart';
import '../../../domain/model/display/cart/cart.model.dart';
import '../../main/bloc/payment_bloc/payment_bloc.dart';
import '../../main/component/payment/payment_button.dart';
import '../../main/component/top_app_bar/widgets/svg_icon_button.dart';
import 'bloc/cart_list_bloc/cart_list_bloc.dart';
import 'component/cart_product_card.dart';
import 'component/cart_total_price.dart';

class CartListPage extends StatelessWidget {
  const CartListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<CartListBloc>(context)
        ..add(
          CartListInitialized(),
        ),
      child: CartListPageView(),
    );
  }
}

class CartListPageView extends StatelessWidget {
  const CartListPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return BlocProvider(
      create: (_) => getIt<PaymentBloc>(),
      child: Scaffold(
        appBar: AppBar(
          leading: Center(
            child: SvgIconButton(
              icon: AppIcons.close,
              color: colorScheme.contentPrimary,
              onPressed: () {
                if (context.canPop()) {
                  context.pop();
                }
              },
            ),
          ),
          title: Text('장바구니', style: textTheme.titleMedium.semiBold?.copyWith(color: colorScheme.contentPrimary)),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: BlocBuilder<CartListBloc, CartListState>(builder: (context, state) {
                final bool isSeletedAll =
                    state.selectedProduct.length == state.cartList.length && state.cartList.isNotEmpty;

                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgIconButton(
                          icon: isSeletedAll ? AppIcons.checkMarkCircleFill : AppIcons.checkMarkCircle,
                          color: isSeletedAll ? colorScheme.primary : colorScheme.contentFourth,
                          onPressed: () {
                            //Todo 전체 선택
                            context.read<CartListBloc>().add(CartListSelectedAll());
                          },
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          '전체 선택 (${state.selectedProduct.length}/${state.cartList.length}) ',
                          style: textTheme.titleSmall?.copyWith(color: colorScheme.contentPrimary),
                        ),
                      ],
                    ),
                    GestureDetector(
                      child: Text(
                        '선택삭제',
                        style: textTheme.titleSmall.semiBold?.copyWith(color: colorScheme.contentSecondary),
                      ),
                      onTap: () {
                        context.read<CartListBloc>().add(CartListDeleted(productIds: state.selectedProduct));
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
        body: BlocBuilder<CartListBloc, CartListState>(
          builder: (_, state) {
            switch (state.status) {
              case Status.initial:
              case Status.loading:
              case Status.error:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case Status.success:
                return ListView(
                  children: [
                    Divider(
                      height: 8,
                      thickness: 8,
                      color: colorScheme.surface,
                    ),
                    //Todo 상품카드 구현
                    Column(
                      children:
                          List.generate(state.cartList.length, (index) => CartProductCard(cart: state.cartList[index])),
                    ),
                    CartTotalPrice(),
                  ],
                );
            }
          },
        ),
        bottomNavigationBar: SafeArea(
          child: BlocBuilder<CartListBloc, CartListState>(builder: (context, state) {
            List<Cart> selectedCarLoist = state.cartList.fold([], (prev, cart) {
              if (state.selectedProduct.contains(cart.product.productId)) {
                prev.add(cart);
              }
              return prev;
            });
            return state.status.isSuccess
                ? PaymentButton(
                    seletectedCartList: selectedCarLoist,
                    totalPrice: state.totalPrice,
                  )
                : SizedBox.shrink();
          }),
        ),
      ),
    );
  }
}
