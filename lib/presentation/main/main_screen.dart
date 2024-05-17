import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/constant/app_icons.dart';

import '../../core/utils/snack_bar/common_snack_bar.dart';
import '../pages/category/category_page.dart';
import '../pages/home/home_page.dart';
import '../pages/search/search_page.dart';
import '../pages/user/user_page.dart';
import 'bloc/cart_bloc/cart_bloc.dart';
import 'component/top_app_bar/top_app_bar.dart';
import 'cubit/bottom_nav_cubit.dart';
import 'cubit/mall_type_cubic.dart';
import 'utils/bottom_sheet/cart_bottom_sheet/cart_bottom_sheet.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => BottomNavCubit(),
        ),
        BlocProvider(
          create: (_) => MallTypeCubit(),
        ),
      ],
      child: const MainScreenView(),
    );
  }
}

class MainScreenView extends StatelessWidget {
  const MainScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopAppBar(),
      body: BlocListener<CartBloc, CartState>(
        listener: (context, state) async {
          final bottomSheet =
              await cartBottomSheet(context).whenComplete(() => context.read<CartBloc>().add(CartClosed()));
          final bool isSuccess = bottomSheet ?? false;
          if (isSuccess) {
            CommonSnackBar.addCartSnackBar(context);
          }
        },
        listenWhen: (previous, current) {
          return previous.status.isClosed && current.status.isOpened;
        },
        child: BlocBuilder<BottomNavCubit, BottomNav>(
          builder: (_, state) {
            switch (state) {
              case BottomNav.home:
                return const HomePage();
              case BottomNav.category:
                return const CategoryPage();
              case BottomNav.search:
                return const SearchPage();
              case BottomNav.user:
                return const UserPage();
            }
          },
        ),
      ),
      bottomNavigationBar: BlocBuilder<BottomNavCubit, BottomNav>(builder: (_, state) {
        return BottomNavigationBar(
          items: List.generate(
            BottomNav.values.length,
            (index) => BottomNavigationBarItem(
              icon: SvgPicture.asset(BottomNav.values[index].icon),
              label: BottomNav.values[index].toName,
              activeIcon: SvgPicture.asset(BottomNav.values[index].activeIcon),
            ),
          ),
          onTap: (index) => context.read<BottomNavCubit>().changeIndex(index),
          currentIndex: state.index,
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
        );
      }),
    );
  }
}
