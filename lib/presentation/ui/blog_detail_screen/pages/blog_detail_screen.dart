import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:intl/intl.dart';

import '../../../../domain/entities/blog_detail_entity.dart';
import '../../../../service_locator.dart';
import '../../../../untils/resource.dart';
import '../bloc/bloc_detail_cubit.dart';
import '../widgets/toc_bottom_sheet.dart';

class BlogDetailScreen extends StatefulWidget {
  final int blogId;

  const BlogDetailScreen({super.key, required this.blogId});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  bool _isBookmarked = false;
  bool _isScrolled = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final Map<String, GlobalKey> _anchorKeys = {};

  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    _animationController.forward();

    //_checkBookmarkStatus();

  }

  void _onScroll() {
    final isScrolled = _scrollController.offset > 200;
    if (isScrolled != _isScrolled) {
      setState(() {
        _isScrolled = isScrolled;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      sl<BlocDetailCubit>()
        ..getBlogDetail(widget.blogId),
      child: BlocBuilder<BlocDetailCubit, Resource<BlogDetailEntity>>(
        builder: (context, state) {
          return state.when(
            onLoading: () => const Center(child: CircularProgressIndicator()),
            onError: (msg) => Center(child: Text("❌ $msg")),
            onSuccess: (data) => _buildBlogDetail(data),
          );
        },
      ),
    );
  }

  Widget _buildBlogDetail(BlogDetailEntity blog) {
    _initAnchorKeys(blog.tableOfContents ?? []);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;
    return Scaffold(
      body: Stack(
        children: [
          // Main scrollable content
          CustomScrollView(
            controller: _scrollController,
            slivers: [
              // Featured image with gradient overlay
              SliverAppBar(
                expandedHeight: 300,
                pinned: true,
                backgroundColor: _isScrolled
                    ? theme.appBarTheme.backgroundColor
                    : Colors.transparent,
                elevation: 0,
                leading: BackButton(
                  color: _isScrolled ? colorScheme.onSurface : Colors.white,
                ),
                actions: [
                  IconButton(
                    icon: AnimatedCrossFade(
                      firstChild: Icon(
                        Icons.bookmark,
                        color: _isScrolled ? colorScheme.primary : Colors.white,
                      ),
                      secondChild: Icon(
                        Icons.bookmark_border,
                        color: _isScrolled ? colorScheme.onSurface : Colors
                            .white,
                      ),
                      crossFadeState: _isBookmarked
                          ? CrossFadeState.showFirst
                          : CrossFadeState.showSecond,
                      duration: const Duration(milliseconds: 200),
                    ),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.share_outlined,
                      color: _isScrolled ? colorScheme.onSurface : Colors.white,
                    ),
                    onPressed: () {
                      // Share functionality would go here
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('Share functionality coming soon')),
                      );
                    },
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    fit: StackFit.expand,
                    children: [
                      // Featured image
                      Hero(
                        tag: 'blog-image-${blog.id}',
                        child: Image.network(
                          blog.thumbnailUrl.toString(),
                          fit: BoxFit.cover,
                        ),
                      ),
                      // Gradient overlay
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.black.withOpacity(0.3),
                              Colors.black.withOpacity(0.7),
                            ],
                          ),
                        ),
                      ),
                      // Title and author info at the bottom
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Category chip
                                if (blog.categoryDto?.name != null)
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                      color: colorScheme.primary,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      blog.categoryDto?.name ?? '',
                                      style: textTheme.labelSmall?.copyWith(
                                        color: colorScheme.onPrimary,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 12),

                                // Title
                                Text(
                                  blog.title ?? '',
                                  style: textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 8),

                                // Subtitle
                                Text(
                                  blog.description ?? '',
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: textTheme.titleMedium?.copyWith(
                                    color: Colors.white.withOpacity(0.9),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 16),

                                // Author row
                                Row(
                                  children: [
                                    // Author image
                                    CircleAvatar(
                                      radius: 20,
                                      backgroundImage: NetworkImage(
                                          "https://c-ssl.duitang.com/uploads/blog/202012/22/20201222002258_2c9d7.jpg"),
                                    ),
                                    const SizedBox(width: 12),

                                    // Author info
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Text(
                                          blog.authorDto?.username ?? '',
                                          style: textTheme.titleMedium
                                              ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '${_formatDateFromString(
                                              blog.createdAt ??
                                                  '')} · 7 min read',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: Colors.white.withOpacity(
                                                0.8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Blog content
              SliverToBoxAdapter(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        // Blog content
                        Html(
                          data: blog.content ?? '',
                        ),
                        const SizedBox(height: 24),

                        // Engagement section
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildEngagementButton(
                              icon: Icons.favorite_outline,
                              label: '243',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text(
                                      'Like functionality coming soon')),
                                );
                              },
                              colorScheme: colorScheme,
                              textTheme: textTheme,
                            ),
                            _buildEngagementButton(
                              icon: Icons.comment_outlined,
                              label: '41',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text(
                                      'Comments functionality coming soon')),
                                );
                              },
                              colorScheme: colorScheme,
                              textTheme: textTheme,
                            ),
                            _buildEngagementButton(
                              icon: Icons.bookmark_outline,
                              label: 'Save',
                              onTap: () {},
                              colorScheme: colorScheme,
                              textTheme: textTheme,
                              isSelected: _isBookmarked,
                            ),
                            _buildEngagementButton(
                              icon: Icons.share_outlined,
                              label: 'Share',
                              onTap: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text(
                                      'Share functionality coming soon')),
                                );
                              },
                              colorScheme: colorScheme,
                              textTheme: textTheme,
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),

                        // Author section
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 28,
                                backgroundImage: NetworkImage("https://c-ssl.duitang.com/uploads/blog/202012/22/20201222002258_2c9d7.jpg")
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Written by',
                                      style: textTheme.bodySmall?.copyWith(
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      blog.authorDto?.displayName ?? "",
                                      style: textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      'Passionate writer and researcher specializing in bruh. Connect with me to discuss more about this topic.',
                                      style: textTheme.bodyMedium,
                                    ),
                                    const SizedBox(height: 8),
                                    TextButton(
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(content: Text('Follow functionality coming soon')),
                                        );
                                      },
                                      child: const Text('Follow'),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Back-to-top button
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            right: 20,
            bottom: _isScrolled ? 20 : -60, // Hide when at the top
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: _isScrolled ? 1.0 : 0.0,
              child: FloatingActionButton(
                mini: true,
                backgroundColor: colorScheme.primary,
                onPressed: () {
                  _showTocBottomSheet(context, blog.tableOfContents ?? [], "1");
                },
                child: Icon(
                  Icons.arrow_upward,
                  color: colorScheme.onPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEngagementButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required ColorScheme colorScheme,
    required TextTheme textTheme,
    bool isSelected = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Icon(
              isSelected ? Icons.bookmark : icon,
              color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
              size: 24,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: textTheme.bodySmall?.copyWith(
                color: isSelected ? colorScheme.primary : colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateFromString(String dateStr) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final date = inputFormat.parse(dateStr); // 👈 chuyển chuỗi sang DateTime

    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return DateFormat('MMM d, yyyy').format(date); // → Apr 15, 2025
    }
  }

  void _showTocBottomSheet(
      BuildContext context,
      List<TableOfContents> tocList,
      String? currentAnchorId,
      ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => TocBottomSheet(
        tocList: tocList,
        currentAnchorId: currentAnchorId,
        onAnchorTap: (id) {_scrollToAnchor(id);},
      ),
    );
  }

  void _scrollToAnchor(String id) {
    final key = _anchorKeys[id];
    if (key?.currentContext != null) {
      Scrollable.ensureVisible(
        key!.currentContext!,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      print("⚠️ Không tìm thấy anchor: $id");
    }
  }


  void _initAnchorKeys(List<TableOfContents> tocList) {
    for (var toc in tocList) {
      final id = _generateAnchorIdFromText(toc.text ?? '');
      _anchorKeys[id] = GlobalKey();
    }
  }

  String _generateAnchorIdFromText(String text) {
    return text
        .toLowerCase()
        .replaceAll(RegExp(r'[^\w\s-]'), '')
        .replaceAll(' ', '-')
        .replaceAll(RegExp(r'-+'), '-');
  }
}
