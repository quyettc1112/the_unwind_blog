import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:the_unwind_blog/presentation/home_screen/pages/home_screen.dart';

import 'common/widgets/bottom_nav/bottom_nav_slide.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

