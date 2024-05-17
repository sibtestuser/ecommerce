import 'package:go_router/go_router.dart';

import '../../../../core/theme/constant/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/theme/custom/custom_app_bar.dart';
import '../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../core/theme/custom/custom_theme.dart';
import '../../../pages/cart_list/bloc/cart_list_bloc/cart_list_bloc.dart';
import '../../../routes/route_path.dart';
import '../../cubit/mall_type_cubic.dart';
import 'widgets/svg_icon_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return AnimatedContainer(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8.0),
          color: state.theme.backgroundColor,
          child: AppBar(
            leading: SvgIconButton(
              icon: AppIcons.mainLogo,
              color: state.theme.logoColor,
              padding: 8,
              onPressed: null,
            ),
            // leading: Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: SvgPicture.asset(
            //     AppIcons.mainLogo,
            //     colorFilter: ColorFilter.mode(
            //       state.theme.logoColor,
            //       BlendMode.srcIn,
            //     ),
            //   ),
            // ),
            title: AnimatedContainer(
              decoration: BoxDecoration(
                color: state.theme.containerColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
              ),
              child: SizedBox(
                height: 28,
                child: DefaultTabController(
                  length: MallType.values.length,
                  initialIndex: state.index,
                  child: TabBar(
                    tabs: List.generate(
                      MallType.values.length,
                      (index) => Tab(text: MallType.values[index].toName),
                    ),
                    isScrollable: true,
                    indicator: BoxDecoration(
                      color: state.theme.indicatorColor,
                      borderRadius: BorderRadius.all(Radius.circular(CustomAppBarTheme.tabBarRadius)),
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    labelColor: state.theme.labelColor,
                    labelStyle: Theme.of(context).textTheme.labelLarge.bold,
                    labelPadding: EdgeInsets.symmetric(horizontal: 12),
                    unselectedLabelColor: state.theme.unselectedLabelColor,
                    unselectedLabelStyle: Theme.of(context).textTheme.labelLarge,
                    onTap: (index) {
                      context.read<MallTypeCubit>().changeIndex(index);
                    },
                    splashBorderRadius: BorderRadius.all(Radius.circular(CustomAppBarTheme.tabBarRadius)),
                  ),
                ),
              ),
              duration: Duration(milliseconds: 400),
            ),
            actions: [
              SvgIconButton(
                icon: AppIcons.location,
                color: state.theme.iconColor,
                onPressed: null,
              ),
              Stack(
                children: [
                  SvgIconButton(
                    icon: AppIcons.cart,
                    color: state.theme.iconColor,
                    onPressed: () => context.push(RoutePath.cart_list),
                  ),
                  Positioned(
                    top: 2,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: state.theme.badgeBgColor,
                      ),
                      width: 13,
                      height: 13,
                      child: Center(
                          child: Text(
                        '${context.watch<CartListBloc>().state.cartList.length}',
                        style: TextStyle(color: state.theme.badgeNumColor, fontSize: 9, fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                ],
              ),
            ],
            backgroundColor: Colors.transparent,
            centerTitle: true,
            leadingWidth: 86,
          ),
          duration: Duration(milliseconds: 400),
        );
      },
    );
  }
}
