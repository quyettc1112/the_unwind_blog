import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';
import 'package:the_unwind_blog/common/widgets/appbar/app_bar.dart';
import 'package:the_unwind_blog/common/widgets/state/empty_state.dart';
import 'package:the_unwind_blog/common/widgets/tabbar/custom_tabbar.dart';

import '../../../common/bloc/blog_provider.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../domain/entities/blog_entity.dart';
import '../../../gen/assets.gen.dart';
import '../widgets/blog_card.dart';
import '../widgets/filter_chips.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  bool _isLoading = true;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _tabController = TabController(length: 3, vsync: this);

    // Initialize blogs data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initData();
    });
  }

  Future<void> _initData() async {
    setState(() {
      _isLoading = true;
    });

    final blogProvider = Provider.of<BlogProvider>(context, listen: false);
    await blogProvider.initBlogs();

    setState(() {
      _isLoading = false;
    });

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildHomeContent());
  }

  Widget _buildHomeContent() {
    final blogProvider = Provider.of<BlogProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return RefreshIndicator(
      color: colorScheme.primary,
      onRefresh: _initData,
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor:
                  context.isDarkMode
                      ? AppColors.background_black
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
              delegate: SliverChildBuilderDelegate((_, int index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [CustomTabBar(tabController: _tabController)],
                );
              }, childCount: 1),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            buildTabContent(
              blogs: blogProvider.filteredBlogs,
              blogProvider: blogProvider,
            ),
            buildTabContent(
              blogs: blogProvider.blogs,
              blogProvider: blogProvider,
            ),
            buildTabContent(
              blogs: blogProvider.blogs,
              blogProvider: blogProvider,
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTabContent({
    required List<Blog> blogs,
    required BlogProvider blogProvider,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: buildBlogList(
        blogs: blogs,
        fadeAnimation: _fadeAnimation,
        isBlogBookmarked: blogProvider.isBlogBookmarked,
        onToggleBookmark: blogProvider.toggleBookmark,
        onTapBlog: _navigateToBlogDetail,
        blogProvider: blogProvider,
      ),
    );
  }

  Widget buildBlogList({
    required List<Blog> blogs,
    required Animation<double> fadeAnimation,
    required Future<bool> Function(String blogId) isBlogBookmarked,
    required void Function(String blogId) onToggleBookmark,
    required void Function(String blogId) onTapBlog,
    required BlogProvider blogProvider,
  }) {
    if (blogs.isEmpty) {
      return Center(child: Text('Không có blog nào để hiển thị'));
    }
    return ListView.builder(
      padding: EdgeInsets.only(top: 10, bottom: 90),
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: blogs.length,
      itemBuilder: (context, index) {
        final adjustedIndex = index;
        final blog = blogs[adjustedIndex];
        return FutureBuilder<bool>(
          future: isBlogBookmarked(blog.id),
          builder: (context, snapshot) {
            final isBookmarked = snapshot.data ?? false;
            return FadeTransition(
              opacity: fadeAnimation,
              child: BlogCard(
                blog: blog,
                isBookmarked: isBookmarked,
                onToggleBookmark: onToggleBookmark,
                onTap: onTapBlog,
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildFeaturedBlog(BlogProvider blogProvider) {
    if (blogProvider.filteredBlogs.isEmpty) {
      return const SizedBox.shrink();
    }

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    final featuredBlog = blogProvider.filteredBlogs.first;

    return FutureBuilder<bool>(
      future: blogProvider.isBlogBookmarked(featuredBlog.id),
      builder: (context, snapshot) {
        final isBookmarked = snapshot.data ?? false;

        return Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today's Pick label
              Row(
                children: [
                  Icon(Icons.star_rounded, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    "Editor's Pick",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppColors.red_button,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),

              // Featured blog card
              FadeTransition(
                opacity: _fadeAnimation,
                child: BlogCard(
                  blog: featuredBlog,
                  isBookmarked: isBookmarked,
                  onToggleBookmark: (blogId) {
                    blogProvider.toggleBookmark(blogId);
                  },
                  onTap: (blogId) {
                    _navigateToBlogDetail(blogId);
                  },
                ),
              ),

              // Popular section divider
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 8),
                child: Row(
                  children: [
                    Icon(
                      Icons.whatshot_rounded,
                      color: colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Latest Blogs',
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildProfilePlaceholder() {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.person_rounded,
            size: 64,
            color: colorScheme.primary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text('Profile', style: textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            'Profile section coming soon',
            style: textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  void _navigateToBlogDetail(String blogId) {
    final blog = Provider.of<BlogProvider>(
      context,
      listen: false,
    ).getBlogById(blogId);
    Provider.of<BlogProvider>(
      context,
      listen: false,
    ).addToReadingHistory(blogId);

    /*Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => BlogDetailScreen(blog: blog),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 0.05);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: FadeTransition(
              opacity: animation,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );*/
  }
}
