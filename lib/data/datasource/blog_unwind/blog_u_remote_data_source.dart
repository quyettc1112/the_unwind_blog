import '../../../core/network/app_api.dart';
import '../../models/blog_unwind_model.dart';

abstract class BlogURemoteSource {
  Future<List<BlogUnwindModel>> getUser();
}

class BlogURemoteSourceImp implements BlogURemoteSource {
  BlogURemoteSourceImp(this._appServiceClient);
  AppServiceClient _appServiceClient;


  @override
  Future<List<BlogUnwindModel>> getUser() async {
    return await _appServiceClient.getBlogs();
  }
}
