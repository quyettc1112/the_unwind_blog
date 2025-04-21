import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/blog_detail_entity.dart';
import '../../../../service_locator.dart';
import '../../../../untils/resource.dart';
import '../bloc/bloc_detail_cubit.dart';

class BlogDetailScreen extends StatefulWidget {
  final int blogId;

  const BlogDetailScreen({super.key, required this.blogId});

  @override
  State<BlogDetailScreen> createState() => _BlogDetailScreenState();
}

class _BlogDetailScreenState extends State<BlogDetailScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BlocDetailCubit>()..getBlogDetail(widget.blogId),
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            blog.title ?? '',
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(blog.slug ?? '', style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
