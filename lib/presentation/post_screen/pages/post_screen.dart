import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';
import '../../../common/widgets/appbar/app_bar.dart';
import '../../../common/widgets/tabbar/circle_tab_indicator.dart';
import '../../../core/config/theme/app_colors.dart';

class PostScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(title: Text('Post Screen')),
      body: MediaQuery.removePadding(
        context: context,
        removeLeft: true,
        child: CustomTabBarExample(),
      ),
    );
  }
}

class CustomTabBarExample extends StatefulWidget {
  @override
  _CustomTabBarExampleState createState() => _CustomTabBarExampleState();
}

class _CustomTabBarExampleState extends State<CustomTabBarExample>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late AnimationController _animationController;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    // Initialize TabController
    _tabController = TabController(length: 3, vsync: this);

    // Initialize AnimationController
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Set up an opacity animation from 0 to 1
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Start the animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Custom TabBar
          Container(
            child: Row(
              children: [
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: false,
                      labelColor:
                          context.isDarkMode
                              ? AppColors.background_white
                              : AppColors.background_black,
                      unselectedLabelColor: Colors.grey,
                      indicator: CircleTabIndicator(
                        color: Colors.black,
                        radius: 4,
                      ),
                      labelPadding: EdgeInsets.only(right: 30),
                      indicatorPadding: EdgeInsets.zero,
                      tabs: [
                        Tab(
                          child: Text(
                            'For You',
                            style: TextStyle(
                              fontSize: 14, // 👈 Cỡ chữ
                              fontWeight: FontWeight.bold, // 👈 Đậm chữ
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Following',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Tab(
                          child: Text(
                            'Technology',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Icon
                Container(
                  margin: EdgeInsets.only(left: 10, right: 15),
                  // Cách tab một xíu
                  child: Icon(Icons.search, size: 30),
                ),
              ],
            ),
          ),
          Container(
            width: double.maxFinite,
            height: 300,
            child: TabBarView(
              controller: _tabController,
              children: [Text('Hi'), Text('There'), Text('Here')],
            ),
          ),
        ],
      ),
    );
  }
}
