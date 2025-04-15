import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../models/blog_unwind_model.dart';

abstract class BlogRemoteDataSource {
  Future<List<BlogUnwindModel>> getAllBlogs();

  Future<BlogUnwindModel> getBlogById(int id);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final Dio dio;

  BlogRemoteDataSourceImpl(this.dio);

  @override
  Future<List<BlogUnwindModel>> getAllBlogs() async {
    try {
      final response = await dio.get('/blog'); // ✅ Đổi path phù hợp API bạn
      final List<dynamic> data = response.data;
      return data.map((e) => BlogUnwindModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }

  @override
  Future<BlogUnwindModel> getBlogById(int id) async {
    try {
      final response = await dio.get('/blog/$id'); // ✅ API get by id
      return BlogUnwindModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    }
  }
}
