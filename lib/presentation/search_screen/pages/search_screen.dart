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

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabContoller;


  @override
  void initState() {
    tabContoller = new TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return  DefaultTabController(
      length: 3,
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              // App Bar
              SliverAppBar(
                backgroundColor:
                context.isDarkMode
                    ? AppColors
                    .background_black // Light theme primary color
                    : AppColors.background_white,
                title: Row(
                  children: [
                    Text(
                      'The Unwind Blog',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
                floating: true,
                actions: [
                  IconButton(
                    icon: Icon(Icons.edit_outlined, color: colorScheme.onSurface),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
                      color: colorScheme.onSurface,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                      (_, int index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTabBar(
                          tabController: tabContoller,
                        )
                      ],
                    );
                  },
                  childCount: 1,
                ),
              ),
            ];
          },
          body: TabBarView(
            children: <Widget>[
              Text("FIRST TAB"),
              Text("SECOND TAB"),
              Text("THIRD TAB"),
            ],
          ),
        ),
      ),
    );
  }
}

