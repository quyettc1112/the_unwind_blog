import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:the_unwind_blog/common/widgets/appbar/app_bar.dart';

import '../../../common/bloc/blog_provider.dart';
import '../../../gen/assets.gen.dart';
import '../widgets/blog_card.dart';
import '../widgets/filter_chips.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;

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
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        title: Text('The Unwind Blog'),
        showBackButton: false,  // Hiển thị nút back
        showNotificationsIcon: true,  // Hiển thị biểu tượng thông báo
        showEditIcon: true,  // Hiển thị biểu tượng chỉnh sửa
        onBackPressed: () {
          // Xử lý sự kiện khi nhấn nút back
          print("Back clicked");
        },
        onNotificationsPressed: () {
          // Xử lý sự kiện khi nhấn vào biểu tượng thông báo
          print("Notifications clicked");
        },
        onEditPressed: () {
          // Xử lý sự kiện khi nhấn vào biểu tượng chỉnh sửa
          print("Edit clicked");
        }, // Hiển thị biểu tượng tìm kiếm
      ),
      body: _buildHomeContent(),
    );
  }

  Widget _buildHomeContent() {
    final blogProvider = Provider.of<BlogProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return RefreshIndicator(
      color: colorScheme.primary,
      onRefresh: _initData,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          // App Bar
          SliverAppBar(
            title: Row(
              children: [
                Icon(
                  Icons.spa_outlined,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Unwind',
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: colorScheme.primary,
                  ),
                ),
              ],
            ),
            floating: true,
            actions: [
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: colorScheme.onSurface,
                ),
                onPressed: () {},
              ),
            ],
          ),

          // Filter Chips
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: FilterChips(
                categories: blogProvider.categories,
                selectedCategory: blogProvider.selectedCategory,
                onCategorySelected: (category) {
                  blogProvider.filterByCategory(category);
                },
              ),
            ),
          ),

          // Main Content
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(),
              ),
            )
          else if (blogProvider.filteredBlogs.isEmpty)
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.article_outlined,
                      size: 64,
                      color: colorScheme.primary.withOpacity(0.5),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No blogs found',
                      style: textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try selecting a different category',
                      style: textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            SliverList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
                  if (index == 0) {
                    // Featured Blog
                    return _buildFeaturedBlog(blogProvider);
                  }

                  final adjustedIndex = index - 1;
                  if (adjustedIndex < blogProvider.filteredBlogs.length) {
                    final blog = blogProvider.filteredBlogs[adjustedIndex];
                    return FutureBuilder<bool>(
                      future: blogProvider.isBlogBookmarked(blog.id),
                      builder: (context, snapshot) {
                        final isBookmarked = snapshot.data ?? false;
                        return FadeTransition(
                          opacity: _fadeAnimation,
                          child: BlogCard(
                            blog: blog,
                            isBookmarked: isBookmarked,
                            onToggleBookmark: (blogId) {
                              blogProvider.toggleBookmark(blogId);
                            },
                            onTap: (blogId) {
                              _navigateToBlogDetail(blogId);
                            },
                          ),
                        );
                      },
                    );
                  }

                  return null;
                },
                childCount: blogProvider.filteredBlogs.isEmpty
                    ? 0
                    : blogProvider.filteredBlogs.length + 1, // +1 for featured blog
              ),
            ),

          // Bottom padding
          const SliverToBoxAdapter(
            child: SizedBox(height: 16),
          ),
        ],
      ),
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
          margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Today's Pick label
              Row(
                children: [
                  Icon(
                    Icons.star_rounded,
                    color: colorScheme.primary,
                    size: 20,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    "Editor's Pick",
                    style: textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

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
                padding: const EdgeInsets.only(top: 24, bottom: 8),
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
          Text(
            'Profile',
            style: textTheme.titleLarge,
          ),
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
    final blog = Provider.of<BlogProvider>(context, listen: false).getBlogById(blogId);
    Provider.of<BlogProvider>(context, listen: false).addToReadingHistory(blogId);

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