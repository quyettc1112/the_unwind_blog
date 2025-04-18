import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_unwind_blog/presentation/home_screen/bloc/blog_cubit.dart';

import '../../../domain/entities/blog_unwind_entity.dart';
import '../../../untils/logger_settigns.dart';
import '../../../untils/resource.dart';
import '../../home_screen/bloc/blog_state.dart';

class SearchScreen extends StatefulWidget {
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    context.read<BlogCubit>().getBlogs();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<BlogCubit, Resource<BlogPaginatedEntity>>(
      listener: (context, state) {
        print("📡 ĐÃ NHẬN STATE: ${state.runtimeType}");

        state.when(
          onLoading: () => print("🔄 Đang tải dữ liệu..."),
          onSuccess: (data) {
            print("✅ Có ${data.content.length} blogs");
            for (var blog in data.content) {
              print("📝 Blog: ${blog.title} | Created at: ${blog.createdAt}");
            }
          },
          onError: (msg) => print("❌ Lỗi: $msg"),
        );
      },
      child: Scaffold(body: Center(child: Text("Search Screen"))),
    );
  }
}
