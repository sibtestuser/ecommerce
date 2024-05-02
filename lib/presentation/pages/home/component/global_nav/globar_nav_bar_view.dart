import 'package:flutter/material.dart';

import '../../../../../domain/model/display/menu/menu.model.dart';
import '../../../../main/cubit/mall_type_cubic.dart';

class GlobalNavTabBarView extends StatelessWidget {
  const GlobalNavTabBarView({super.key, required this.menus, required this.mallType});
  final List<Menu> menus;
  final MallType mallType;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        children: List.generate(
          menus.length,
          (index) => Column(
            children: [
              Text('mallType : ${mallType}'),
              Text('menu : ${menus[index].title}'),
            ],
          ),
        ),
      ),
    );
  }
}
