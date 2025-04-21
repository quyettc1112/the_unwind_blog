import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_unwind_blog/common/widgets/button/basic_app_button.dart';
import 'package:the_unwind_blog/core/config/theme/app_colors.dart';

import '../../../../common/bloc/blog_provider.dart';
import '../../../../common/widgets/appbar/app_bar.dart';
import '../../../../common/widgets/button/rounded_button_red.dart';
import '../../../../domain/entities/blog_entity.dart';
import '../../home_screen/widgets/blog_card.dart';
class BookmarksScreen extends StatefulWidget {
  const BookmarksScreen({super.key});

  @override
  State<BookmarksScreen> createState() => _BookmarksScreenState();
}

class _BookmarksScreenState extends State<BookmarksScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BlogProvider>(context, listen: false).loadBookmarkedBlogs();
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final blogProvider = Provider.of<BlogProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: BasicAppBar(title: Text('Bookmarks Screen')),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child:
            blogProvider.bookmarkedBlogs.isEmpty
                ? _buildEmptyState(colorScheme, textTheme)
                : _buildBookmarksList(blogProvider),
      ),
    );
  }

  Widget _buildEmptyState(ColorScheme colorScheme, TextTheme textTheme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            curve: Curves.elasticOut,
            height: 120,
            child: Icon(Icons.bookmark_outline, size: 80, color: Colors.blue),
          ),
          const SizedBox(height: 24),
          Text(
            'No Bookmarks Yet',
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Start bookmarking your favorite blogs\nto access them easily later',
            style: textTheme.bodyLarge?.copyWith(
              color: colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          RoundedButton(onPressed: () {}, text: 'Explore Blogs'),
        ],
      ),
    );
  }

  Widget _buildBookmarksList(BlogProvider blogProvider) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 16),
      itemCount: blogProvider.bookmarkedBlogs.length,
      itemBuilder: (context, index) {
        // Add staggered animation effect
        final Animation<double> animation = CurvedAnimation(
          parent: _animationController,
          curve: Interval(
            (1 / blogProvider.bookmarkedBlogs.length) * index,
            (1 / blogProvider.bookmarkedBlogs.length) * (index + 1),
            curve: Curves.easeInOut,
          ),
        );

        final blog = blogProvider.bookmarkedBlogs[index];

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.5, 0),
              end: Offset.zero,
            ).animate(animation),
            child: BlogCard(
              blog: blog,
              isBookmarked: true,
              onToggleBookmark: (blogId) {
                blogProvider.toggleBookmark(blogId);
              },
              onTap: (blogId) {
                _navigateToBlogDetail(blog);
              },
              isHorizontal: true,
            ),
          ),
        );
      },
    );
  }

  void _navigateToBlogDetail(Blog blog) {
    Provider.of<BlogProvider>(
      context,
      listen: false,
    ).addToReadingHistory(blog.id);

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
    )*/
    ;
  }
}
