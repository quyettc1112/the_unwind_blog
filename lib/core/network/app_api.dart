
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

import '../../data/models/blog_unwind_model.dart';
import '../constants/constant.dart';

part 'app_api.g.dart';

class ApisEndpoint {
  static const String getBlogs = "/public/blogs";
}

@RestApi(baseUrl: Constant.baseUrl)
abstract class AppServiceClient {
  factory AppServiceClient(Dio dio, {String baseUrl}) = _AppServiceClient;
  @GET(ApisEndpoint.getBlogs)
  Future<List<BlogUnwindModel>> getBlogs();
}
