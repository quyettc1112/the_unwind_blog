import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';
import 'package:the_unwind_blog/services/data_service.dart';

class BlogUnwindCard extends StatefulWidget {
  final BlogEntity blogs;

  /*  final bool isBookmarked;
  final Function(int) onToggleBookmark;*/
  final Function(int) onTap;
  final bool isHorizontal;

  const BlogUnwindCard({
    Key? key,
    required this.blogs,
    /*    required this.isBookmarked,
    required this.onToggleBookmark,*/
    required this.onTap,
    this.isHorizontal = false,
  }) : super(key: key);

  @override
  State<BlogUnwindCard> createState() => _BlogUnwindCardState();
}

class _BlogUnwindCardState extends State<BlogUnwindCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late List<String> tags;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.97,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    tags = DataService().getMockBlogs().first.tags;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onTap(widget.blogs.id);
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(scale: _scaleAnimation.value, child: child);
        },
        child: _buildVerticalCard(textTheme, colorScheme),
      ),
    );
  }

  Widget _buildVerticalCard(TextTheme textTheme, ColorScheme colorScheme) {
    return Container(
      margin: const EdgeInsets.only(left: 5, right: 5, bottom: 20),
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(0, 1),
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image with bookmark button and category tags
          Stack(
            children: [
              // Featured image
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                child: AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    widget.blogs.thumbnailUrl,
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      if (loadingProgress == null) return child;
                      return Container(
                        color: colorScheme.surfaceVariant,
                        child: Center(
                          child: CircularProgressIndicator(
                            value:
                                loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                            color: colorScheme.primary,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Bookmark button
              Positioned(
                top: 10,
                right: 10,
                child: AnimatedScale(
                  // scale: widget.isBookmarked ? 0.8 : 0.7,
                  scale: 0.7,
                  duration: const Duration(milliseconds: 200),
                  child: Container(
                    decoration: BoxDecoration(
                      color: colorScheme.surface.withOpacity(0.9),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      /*icon: Icon(
                        widget.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color:
                        widget.isBookmarked
                            ? colorScheme.primary
                            : colorScheme.onSurface,
                      ),
                      onPressed: () => widget.onToggleBookmark(widget.blogs.id),*/
                      icon: const Icon(
                        Icons.bookmark_border,
                        color: Colors.black,
                      ),
                      iconSize: 20,
                      padding: const EdgeInsets.all(3),
                      constraints: const BoxConstraints(),
                      onPressed: () => {},
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Content
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
              right: 5,
              top: 12,
              bottom: 12,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  widget.blogs.title,
                  style: textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),

                // Subtitle
                Text(
                  widget.blogs.description,
                  style: textTheme.bodyMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 16),

                // Author row
                Row(
                  children: [
                    // Author image
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: colorScheme.primary.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(36),
                        child: Image.network(
                          "https://c-ssl.duitang.com/uploads/blog/202012/22/20201222002258_2c9d7.jpg",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Author name and date
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.blogs.author?.displayName ?? 'Unknown',
                            style: textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${_formatDateFromString(widget.blogs.createdAt)} · 7 min read',
                            style: textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Stats
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_outline,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '243',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Icon(
                          Icons.chat_bubble_outline,
                          size: 16,
                          color: colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '28',
                          style: textTheme.bodySmall?.copyWith(
                            color: colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Category tag
                if (tags.isNotEmpty)
                  Row(
                    children: [
                      // Tag hiển thị tối đa 3
                      ...tags.take(3).map((tag) {
                        return Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            tag,
                            style: textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        );
                      }),

                      // Nếu còn nhiều tag → hiển thị "+N"
                      if (tags.length > 3)
                        Container(
                          margin: const EdgeInsets.only(right: 6),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                          ),
                          child: Text(
                            '+${tags.length - 3}',
                            style: textTheme.labelSmall?.copyWith(
                              color: Colors.grey.shade700,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
