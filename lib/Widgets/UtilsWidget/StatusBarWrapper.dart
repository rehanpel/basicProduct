import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class StatusBarWrapper extends HookWidget {
  final Widget child;
  final SystemUiOverlayStyle brightness;

  const StatusBarWrapper({
    Key? key,
    required this.child,
    this.brightness = SystemUiOverlayStyle.light,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: brightness,
      child: child,
    );
  }
}
