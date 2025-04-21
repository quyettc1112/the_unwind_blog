
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:the_unwind_blog/data/repositories_impl/blog_repository_impl.dart';
import 'package:the_unwind_blog/domain/repositories/blog_unwind_repository.dart';
import 'package:the_unwind_blog/presentation/ui/blog_detail_screen/bloc/bloc_detail_cubit.dart';
import 'package:the_unwind_blog/presentation/ui/home_screen/bloc/blog_cubit.dart';

import 'core/constants/app_url.dart';
import 'core/network/app_api.dart';
import 'core/network/interceptors/logging_interceptor.dart';
import 'core/network/network_info.dart';
import 'data/datasource/blog_unwind/blog_remote_data_source.dart';
import 'domain/usecase/get_blog_detail_usecase.dart';
import 'domain/usecase/get_blogs_usecase.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {

  // DioClient setup
  sl.registerLazySingleton<Dio>(() => Dio(
    BaseOptions(
      baseUrl: '${AppUrl.baseURL}',
      connectTimeout: Duration(seconds: 45),
      receiveTimeout: Duration(seconds: 45),
      sendTimeout: Duration(seconds: 45),
    ),
  )..interceptors.addAll([
    PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: true,
      error: true,
      compact: true,
      maxWidth: 90,
    ),
  ]));

  // Network Info
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  //AppServiceClient
  sl.registerLazySingleton<AppServiceClient>(() => AppServiceClient(sl<Dio>()));

  // Cubit
  sl.registerFactory(() => BlogCubit(sl<GetBlogsUseCase>()));
  sl.registerFactory(() => BlocDetailCubit(sl<GetBlogDetailUseCase>()));

  // Use Case
  sl.registerLazySingleton<GetBlogsUseCase>(() => GetBlogsUseCase(sl()));
  sl.registerLazySingleton<GetBlogDetailUseCase>(() => GetBlogDetailUseCase(sl()));

  // Repository
  sl.registerLazySingleton<BlogUnwindRepository>(() => BlogRepositoryImpl(sl(), sl()));

  // Remote Data Source
  sl.registerLazySingleton<BlogURemoteSource>(() => BlogURemoteSourceImp(sl()));

}