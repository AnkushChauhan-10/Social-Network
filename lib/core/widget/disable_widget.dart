import 'package:flutter/material.dart';

class DisableWidget extends StatelessWidget {
  final bool isDisabled;
  final Widget child;

  const DisableWidget({
    super.key,
    required this.isDisabled,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (isDisabled) {
      return AbsorbPointer(child: Opacity(opacity: 0.5, child: child));
    }
    return child;
  }
}
