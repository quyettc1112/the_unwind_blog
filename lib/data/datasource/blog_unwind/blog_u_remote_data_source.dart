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
}
