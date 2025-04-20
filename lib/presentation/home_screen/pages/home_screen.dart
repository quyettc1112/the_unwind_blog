import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:the_unwind_blog/common/helper/is_dark_mode.dart';
import 'package:the_unwind_blog/common/widgets/tabbar/custom_tabbar.dart';
import 'package:the_unwind_blog/presentation/home_screen/widgets/blog_unwind_card.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import '../../../common/bloc/blog_provider.dart';
import '../../../core/config/theme/app_colors.dart';
import '../../../domain/entities/blog_unwind_entity.dart';
import '../../../untils/resource.dart';
import '../bloc/blog_cubit.dart';
import '../widgets/blog_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<double> _fadeAnimation;
  late TabController _tabController;
  late final PagingController<int, BlogEntity> _pagingController;
  int? _totalPages;

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

    _pagingController = PagingController<int, BlogEntity>(
      getNextPageKey: (state) {
        final lastKey = state.keys?.last ?? 0;
        if (_totalPages == null) {return lastKey + 1;}
        if (lastKey >= _totalPages!) {return null;}
        return lastKey + 1;
      },
      fetchPage: (pageKey) async {
        const pageSize = 10;
        final result = await context.read<BlogCubit>().fetchBlogPage(
          pageKey,
          pageSize,
        );
        if (result == null) throw Exception("Lỗi khi tải blog");
        _totalPages ??= result.totalPages;
        return result.content;
      },
    );

    // Initialize blogs data
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initData();
    });
  }

  Future<void> _initData() async {
    _animationController.forward();
    // Fetch first page blogs from the API
    context.read<BlogCubit>().getBlogs(
      pageNo: 1,
      pageSize: 10,
      title: null,
      categoryId: null,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _tabController.dispose();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BlogCubit, Resource<BlogPaginatedEntity>>(
      builder: (context, state) {
        return state.when(
          onLoading:
              () => Scaffold(body: Center(child: CircularProgressIndicator())),
          onError: (msg) => Scaffold(body: Center(child: Text("❌ Lỗi: $msg"))),
          onSuccess:
              (data) => Scaffold(
                body: _buildHomeContent(data), // ✅ truyền đúng data vào đây
              ),
        );
      },
    );
  }

  Widget _buildHomeContent(BlogPaginatedEntity data) {
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
                      : AppColors.white,
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
            buildTabContent(blogs: data.content),
            buildTabContent(blogs: data.content),
            buildTabContent(blogs: data.content),
          ],
        ),
      ),
    );
  }

  Widget buildTabContent({required List<BlogEntity> blogs}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: buildBlogPagedList(
        fadeAnimation: _fadeAnimation,
        onTapBlog: (id) {
          print("👆 Tapped blog with ID: $id");
        },
        pagingController: _pagingController,
      ),
    );
  }

  Widget buildBlogPagedList({
    required Animation<double> fadeAnimation,
    required void Function(int blogId) onTapBlog,
    required PagingController<int, BlogEntity> pagingController,
  }) {
    return PagingListener(
      controller: _pagingController,
      builder: (context, state, fetchNextPage) {
        return PagedListView<int, BlogEntity>.separated(
          state: state,
          fetchNextPage: fetchNextPage,
          padding: const EdgeInsets.only(top: 10, bottom: 90),
          builderDelegate: PagedChildBuilderDelegate<BlogEntity>(
            animateTransitions: true,
            itemBuilder:
                (context, blog, index) =>
                    BlogUnwindCard(blogs: blog, onTap: (id) => {}),
            firstPageErrorIndicatorBuilder:
                (_) => const Text('❌ Lỗi khi tải blog'),
            noItemsFoundIndicatorBuilder:
                (_) => const Text('🤷 Không có blog nào'),
            newPageProgressIndicatorBuilder:
                (_) => const Center(child: CircularProgressIndicator()),
          ),
          separatorBuilder: (_, __) => const Divider(),
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
