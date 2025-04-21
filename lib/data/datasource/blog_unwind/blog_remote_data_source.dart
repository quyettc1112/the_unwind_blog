import 'package:the_unwind_blog/data/models/blog_detail_model.dart';

import '../../../core/network/app_api.dart';
import '../../models/blog_paginated_model.dart';
import '../../models/blog_unwind_model.dart';

abstract class BlogURemoteSource {
  Future<BlogPaginatedResponseModel> getBlogs({
    required int pageNo,
    required int pageSize,
    String? title,
    int? categoryId,
  });

  Future<BlogDetailModel> getBlogDetail({
    required int blogId,
  });

}

class BlogURemoteSourceImp implements BlogURemoteSource {
  BlogURemoteSourceImp(this._appServiceClient);

  AppServiceClient _appServiceClient;

  @override
  Future<BlogPaginatedResponseModel> getBlogs({
    required int pageNo,
    required int pageSize,
    String? title,
    int? categoryId,
  }) async {
    return await _appServiceClient.getBlogs(
      pageNo: pageNo,
      pageSize: pageSize,
      title: title,
      categoryId: categoryId,
    );
  }

  @override
  Future<BlogDetailModel> getBlogDetail({required int blogId}) async {
    return await _appServiceClient.getBlogDetail(blogId);
  }


}
