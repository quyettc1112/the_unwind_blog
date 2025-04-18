import 'package:dartz/dartz.dart';

import 'package:the_unwind_blog/core/error/failures.dart';

import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';
import 'package:the_unwind_blog/untils/typedef.dart';

import '../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/blog_unwind_repository.dart';
import '../datasource/blog_unwind/blog_remote_data_source.dart';

class BlogRepositoryImpl implements BlogUnwindRepository {
  BlogRemoteDataSource _remoteDataSource;
  NetworkInfo _networkInfo;
  BlogRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  ResultFuture<List<BlogEntity>> getBlogs() async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getAllBlogs(); // List<BlogUnwindModel>
        // cast List<BlogUnwindModel> => List<BlogEntity>
        return Right(response.cast<BlogEntity>());
      } catch (e) {
        return Left(Failure(message: "Hata", statusCode: 400));
      }
    } else {
      return Left(Failure(message: "Internet Yok", statusCode: 400));
    }
  }

  @override
  Future<Either<Failure, BlogEntity>> getBlogUnwindById(int id) {
    // TODO: implement getBlogUnwindById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<BlogEntity>>> getBlogUnwindList() {
    // TODO: implement getBlogUnwindList
    throw UnimplementedError();
  }


}