import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/utils/constant.dart';
import '../../../core/utils/dialog/common_dialog.dart';
import '../../../dependency_injection.dart';
import '../../../domain/usecase/display/display.usecase.dart';
import '../../../service_locator.dart';
import '../../main/cubit/mall_type_cubic.dart';
import 'bloc/menu_bloc/menu_bloc.dart';
import 'component/global_nav/global_nav_bar.dart';
import 'component/global_nav/globar_nav_bar_view.dart';
import 'component/view_module_list/view_module_factory/view_module_factory.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(builder: (context, state) {
      return BlocProvider(
        create: (_) => getIt<MenuBloc>()..add(MenuInitialized(state)),
        child: const HomePageView(),
      );
    });
  }
}

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<MallTypeCubit, MallType>(
      listener: (context, state) {
        context.read<MenuBloc>().add(MenuInitialized(state));
      },
      listenWhen: (previous, current) => previous.index != current.index,
      child: BlocConsumer<MenuBloc, MenuState>(
        builder: (_, state) {
          switch (state.status) {
            case Status.initial:
            case Status.loading:
              return DefaultTabController(
                key: ValueKey<MallType>(state.mallType),
                length: state.menus.length,
                child: Column(
                  children: [
                    GlobalNavBar(menus: state.menus),
                    GlobalNavTabBarView(menus: state.menus, mallType: state.mallType),
                  ],
                ),
              );
            case Status.success:
              return DefaultTabController(
                key: ValueKey<MallType>(state.mallType),
                length: state.menus.length,
                child: Column(
                  children: [
                    GlobalNavBar(menus: state.menus),
                    GlobalNavTabBarView(menus: state.menus, mallType: state.mallType),
                  ],
                ),
              );
            case Status.error:
              return Center(
                child: Text('error'),
              );
          }
        },
        listener: (BuildContext context, MenuState state) async {
          if (state.status == Status.error) {
            final bool result = await CommonDialog.errorDialog(context, state.error) ?? false;
            if (result) {
              context.read<MenuBloc>().add(MenuInitialized(state.mallType));
            }
          }
        },
        listenWhen: (previous, current) {
          return previous.status != current.status;
        },
      ),
    );
  }
}
