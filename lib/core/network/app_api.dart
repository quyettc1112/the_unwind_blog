
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:the_unwind_blog/domain/entities/blog_detail_entity.dart';

import '../../data/models/blog_detail_model.dart';
import '../../data/models/blog_paginated_model.dart';
import '../../data/models/blog_unwind_model.dart';
import '../constants/constant.dart';

part 'app_api.g.dart';

class ApisEndpoint {
  static const String getBlogs = "/public/blogs";
  static const String getBlogDetail = "/public/blog";
}

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;

  @GET(ApisEndpoint.getBlogs)
  Future<BlogPaginatedResponseModel> getBlogs({
    @Query("PageNo") required int pageNo,
    @Query("PageSize") required int pageSize,
    @Query("Title") String? title,
    @Query("categoryId") int? categoryId,
  });

  @GET("${ApisEndpoint.getBlogDetail}/{id}")
  Future<BlogDetailModel> getBlogDetail(@Path("id") int blogId);
}
