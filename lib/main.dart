import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'common/widgets/bottom_nav/bottom_nav_slide.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomNavWithSlide(),
    );
  }
}

