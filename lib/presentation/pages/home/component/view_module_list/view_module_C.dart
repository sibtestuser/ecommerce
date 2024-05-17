import 'package:flutter/material.dart';

import 'view_module_factory/view_module_widget.dart';

class ViewModuleC extends StatelessWidget with ViewModuleWidget {
  const ViewModuleC({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.orange,
      height: 200,
      child: Center(child: Text('viewModuleC')),
    );
  }
}
