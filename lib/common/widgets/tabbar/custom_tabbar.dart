import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';

import '../../../core/config/theme/app_colors.dart';
import 'circle_tab_indicator.dart';

class CustomTabBar extends StatefulWidget {
  final TabController tabController;

  const CustomTabBar({Key? key, required this.tabController}) : super(key: key);

  @override
  State<CustomTabBar> createState() => _CustomTabBarState();
}

class _CustomTabBarState extends State<CustomTabBar>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:
          context.isDarkMode
              ? AppColors.background_black
              : AppColors.white,
      child: Row(
        children: [
          Expanded(
            child: TabBar(
              controller: widget.tabController,
              isScrollable: false,
              labelColor:
                  context.isDarkMode
                      ? AppColors.white
                      : AppColors.background_black,
              unselectedLabelColor: Colors.grey,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
              indicator: CircleTabIndicator(
                color: context.isDarkMode ? Colors.white : Colors.black,
                radius: 4,
              ),
              labelPadding: EdgeInsets.only(right: 25),
              indicatorPadding: EdgeInsets.zero,
              tabs: [
                Tab(
                  child: Text(
                    'For You',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Following',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
                Tab(
                  child: Text(
                    'Featured',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 12),
            child: Icon(Icons.filter_alt_outlined, size: 24),
          ),
        ],
      ),
    );
  }
}
