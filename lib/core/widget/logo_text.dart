import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_network/core/constants/assets.dart';

class LogoText extends StatelessWidget {
  const LogoText({super.key, Size? size}) : _size = size ?? const Size(80, 40);

  final Size _size;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(switch (Theme.of(context).brightness) {
      Brightness.dark => Assets.darkLogoTextSvg,
      Brightness.light => Assets.lightLogoTextSvg,
    });
  }
}
