import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/constant.dart';
import '../../../../../dependency_injection.dart';
import '../../../../../domain/model/display/menu/menu.model.dart';
import '../../../../../domain/usecase/display/display.usecase.dart';
import '../../../../../service_locator.dart';
import '../../../../main/cubit/mall_type_cubic.dart';
import '../../bloc/menu_bloc/menu_bloc.dart';
import '../../bloc/view_module_block/view_module_bloc.dart';
import '../view_module_list/view_module_factory/view_module_factory.dart';
import '../view_module_list/view_module_list.dart';

class GlobalNavTabBarView extends StatelessWidget {
  const GlobalNavTabBarView({super.key, required this.menus, required this.mallType});
  final List<Menu> menus;
  final MallType mallType;
  @override
  // Widget build(BuildContext context) {
  //   return Expanded(
  //     child: TabBarView(
  //       children: List.generate(menus.length, (index) {
  //         return BlocProvider(
  //           create: (_) => getIt<ViewModuleBloc>()..add(ViewModuleInitialized(tabId: menus[index].tabId)),
  //           child: ViewModuleList(),
  //         );
  //       }),
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
    return BlocBuilder<MenuBloc, MenuState>(
      builder: (_, state) {
        switch (state.status) {
          case Status.initial:
          case Status.loading:
            return Center(
              child: CircularProgressIndicator(),
            );
          case Status.error:
            return Center(
              child: Text('error'),
            );
          case Status.success:
            return Expanded(
                child: TabBarView(
              children: List.generate(state.menus.length, (index) {
                return BlocProvider(
                  create: (_) => getIt<ViewModuleBloc>()
                    ..add(
                      ViewModuleInitialized(tabId: menus[index].tabId),
                    ),
                  child: ViewModuleList(tabId: menus[index].tabId),
                );
              }),
            ));
        }
      },
    );
  }
}

// class ViewModuleList extends StatelessWidget {
//   const ViewModuleList({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ViewModuleBloc, ViewModuleState>(
//       builder: (_, state) {
//         switch (state.status) {
//           case Status.initial:
//           case Status.loading:
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           case Status.error:
//             return Center(
//               child: Text('error'),
//             );
//           case Status.success:
//             return Column(
//               children: [
//                 Expanded(
//                   child: ListView.separated(
//                     itemBuilder: (_, index) {
//                       return state.viewModules[index];
//                     },
//                     separatorBuilder: (_, index) {
//                       return Divider();
//                     },
//                     itemCount: state.viewModules.length,
//                   ),
//                 ),
//                 // ViewModuleFactory.textToWidget(state.viewModules[0]),
//               ],
//             );
//         }
//       },
//     );
//   }
// }
