import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

extension IsDarkMode on BuildContext {
  bool get isDarkMode {
    return Theme.of(this).brightness == Brightness.dark;
  }
}