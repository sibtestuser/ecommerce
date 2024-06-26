import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/constant/app_icons.dart';
import '../../main/bloc/user_bloc/user_bloc.dart';
import '../../routes/route_path.dart';

//Todo 로그인 bloc
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2), () => context.go(RoutePath.main));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (_, __) {},
      child: Scaffold(
        //Todo 하드코딩 된 값 변경할 것
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(child: SvgPicture.asset(AppIcons.mainLogo)),
      ),
    );
  }
}
