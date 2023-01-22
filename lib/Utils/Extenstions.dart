import 'package:flutter/material.dart';

extension NavigationWithString on String {
  void push(BuildContext context) {
    Navigator.pushNamed(context, this);
  }
  void pushReplace(BuildContext context) {
    Navigator.pushReplacementNamed(context, this);
  }
}
