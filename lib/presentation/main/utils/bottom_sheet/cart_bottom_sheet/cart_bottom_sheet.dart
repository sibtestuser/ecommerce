import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/snack_bar/common_snack_bar.dart';
import '../../../../pages/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
import '../../../bloc/cart_bloc/cart_bloc.dart';
import 'widget/add_cart_btn.dart';
import 'widget/cart_price_info.dart';
import 'widget/cart_product_info.dart';

Future<bool?> cartBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    builder: (context) {
      return SafeArea(
        child: BlocListener<CartListBloc, CartListState>(
          listener: (context, state) {
            if (state.status.isError) {
              CommonSnackBar.errorSnackBar(context, error: state.errorResponse);
            }
            if (context.canPop()) {
              print('[test] status : ${state.status}');
              context.pop(!state.status.isError);
            }
          },
          listenWhen: (previous, current) => previous.status != current.status && !current.status.isLoading,
          child: SingleChildScrollView(
            child: BlocBuilder<CartBloc, CartState>(builder: (context, state) {
              return Column(
                children: [
                  CartProductInfo(),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  ),
                  CartPriceInfo(),
                  AddCartBtn(),
                ],
              );
            }),
          ),
        ),
      );
    },
    showDragHandle: true,
  );
}
