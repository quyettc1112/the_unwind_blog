import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';

import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/tabbar/custom_tabbar.dart';
import '../../../core/config/theme/app_colors.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> with SingleTickerProviderStateMixin {
  late TabController tabContoller;

  @override
  void initState() {
    super.initState();
    tabContoller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    tabContoller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Scaffold(
    );
  }
}