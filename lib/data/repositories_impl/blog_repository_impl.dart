import 'package:dartz/dartz.dart';

import 'package:the_unwind_blog/core/error/failures.dart';

import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';

import '../../core/error/exceptions.dart';
import '../../domain/repositories/blog_unwind_repository.dart';
import '../datasource/blog_unwind/blog_remote_data_source.dart';

class BlogRepositoryImpl implements BlogUnwindRepository {
  final BlogRemoteDataSource remoteDataSource;

  BlogRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, BlogEntity>> getBlogUnwindById(int id) async {
    try {
      final blog = await remoteDataSource.getBlogById(id); //
      return Right(blog);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('An unexpected error occurred'));
    }
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getBlogUnwindList() async {
    try {
      final blogs = await remoteDataSource.getAllBlogs();
      return Right(blogs);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('An unexpected error occurred'));
    }
  }

}