import 'package:dartz/dartz.dart';
import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';

import '../../core/error/failures.dart';
import '../../data/models/blog_paginated_model.dart';
import '../../untils/typedef.dart';
import '../entities/blog_detail_entity.dart';

abstract interface class BlogUnwindRepository {
  ResultFuture<BlogPaginatedEntity> getBlogs({
    required int pageNo,
    required int pageSize,
    String? title,
    int? categoryId,
  });

  ResultFuture<BlogDetailEntity> getBlogDetail(int blogId);
}
