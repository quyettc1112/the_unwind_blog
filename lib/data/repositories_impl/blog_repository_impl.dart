import 'package:dartz/dartz.dart';

import 'package:the_unwind_blog/core/error/failures.dart';
import 'package:the_unwind_blog/data/datasource/blog_unwind/blog_u_remote_data_source.dart';

import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';
import 'package:the_unwind_blog/untils/typedef.dart';

import '../../core/error/exceptions.dart';
import '../../core/network/network_info.dart';
import '../../domain/repositories/blog_unwind_repository.dart';
import '../datasource/blog_unwind/blog_remote_data_source.dart';
import '../models/blog_paginated_model.dart';

class BlogRepositoryImpl implements BlogUnwindRepository {
  BlogURemoteSource _remoteDataSource;
  NetworkInfo _networkInfo;

  BlogRepositoryImpl(this._remoteDataSource, this._networkInfo);

  @override
  ResultFuture<BlogPaginatedEntity> getBlogs({
    required int pageNo,
    required int pageSize,
    String? title,
    int? categoryId,
  }) async {
    if (await _networkInfo.isConnected) {
      try {
        final response = await _remoteDataSource.getBlogs(
          pageNo: pageNo,
          pageSize: pageSize,
          title: title,
          categoryId: categoryId,
        ); // BlogPaginatedResponseModel
        return Right(response.toEntity());
      } catch (e) {
        return Left(Failure(message: e.toString(), statusCode: 400));
      }
    } else {
      return Left(Failure(message: "Internet Yok", statusCode: 400));
    }
  }
}
