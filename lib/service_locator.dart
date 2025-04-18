
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:the_unwind_blog/data/datasource/blog_unwind/blog_u_remote_data_source.dart';
import 'package:the_unwind_blog/data/repositories_impl/blog_repository_impl.dart';
import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';
import 'package:the_unwind_blog/domain/repositories/blog_unwind_repository.dart';
import 'package:the_unwind_blog/presentation/home_screen/bloc/blog_cubit.dart';

import 'core/constants/app_url.dart';
import 'core/network/app_api.dart';
import 'core/network/interceptors/logging_interceptor.dart';
import 'core/network/network_info.dart';
import 'core/usecase/usecase.dart';
import 'data/datasource/blog_unwind/blog_remote_data_source.dart';
import 'data/datasource/user/user_remote_data_source.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecase/get_all_users.dart';
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
  sl.registerFactory(() => BlogCubit(getUsersUseCase: sl()));

  // Use Case
  sl.registerLazySingleton<GetBlogsUseCase>(() => GetBlogsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<BlogUnwindRepository>(() => BlogRepositoryImpl(sl(), sl()));

  // Remote Data Source
  sl.registerLazySingleton<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<BlogURemoteSource>(() => BlogURemoteSourceImp(sl()));

}