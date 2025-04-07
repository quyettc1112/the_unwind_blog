import 'package:dio/dio.dart';

import 'interceptors/api_interceptor.dart';
import 'interceptors/logging_interceptor.dart';

class DioClient {
  // dio client instance
  static final Dio instance = Dio(
    BaseOptions(
      baseUrl: 'https://67eead1fc11d5ff4bf7a8e8b.mockapi.io/',
      connectTimeout: const Duration(seconds: 45),
      receiveTimeout: const Duration(seconds: 45),
      sendTimeout: const Duration(seconds: 45),
    ),
  )..interceptors.addAll(
    [
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
      ApiInterceptor(),
    ],
  );
  Future<Response> get(String url) async {
    return await instance.get(url); // ✅ Phải gọi instance
  }
}