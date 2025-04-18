import '../../../core/network/app_api.dart';
import '../../models/blog_paginated_model.dart';
import '../../models/blog_unwind_model.dart';

abstract class BlogURemoteSource {
  Future<BlogPaginatedResponseModel> getBlogs();
}

class BlogURemoteSourceImp implements BlogURemoteSource {
  BlogURemoteSourceImp(this._appServiceClient);
  AppServiceClient _appServiceClient;


  @override
  Future<BlogPaginatedResponseModel> getBlogs() async {
    return await _appServiceClient.getBlogs();
  }
}
