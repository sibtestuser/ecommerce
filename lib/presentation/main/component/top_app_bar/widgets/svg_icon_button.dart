import 'package:e_commerce_app/core/theme/constant/app_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIconButton extends StatelessWidget {
  const SvgIconButton({
    required this.icon,
    required this.color,
    this.padding = 4.0,
    this.size = 24,
    required this.onPressed,
    super.key,
  });
  final double padding;
  final String icon;
  final Color color;
  final double size;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Padding(
        padding: EdgeInsets.all(this.padding),
        child: SvgPicture.asset(
          icon,
          width: size,
          height: size,
          colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        ),
      ),
      onTap: onPressed,
    );
  }
}
