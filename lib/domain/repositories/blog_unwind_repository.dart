import 'package:dartz/dartz.dart';
import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';

import '../../core/error/failures.dart';
import '../../untils/typedef.dart';

abstract interface class BlogUnwindRepository {
  ResultFuture<List<BlogEntity>> getBlogs();
  Future<Either<Failure, List<BlogEntity>>> getBlogUnwindList();
  Future<Either<Failure, BlogEntity>> getBlogUnwindById(int id);
}