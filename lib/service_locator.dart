
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:the_unwind_blog/data/repositories_impl/blog_repository_impl.dart';
import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';
import 'package:the_unwind_blog/domain/repositories/blog_unwind_repository.dart';
import 'package:the_unwind_blog/domain/usecase/get_all_blog.dart';

import 'core/base_state/base_list_cubit.dart';
import 'core/constants/app_url.dart';
import 'core/network/interceptors/logging_interceptor.dart';
import 'core/usecase/usecase.dart';
import 'data/datasource/blog_unwind/blog_remote_data_source.dart';
import 'data/datasource/user/user_remote_data_source.dart';
import 'data/repositories_impl/user_repository_impl.dart';
import 'domain/repositories/user_repository.dart';
import 'domain/usecase/get_all_users.dart';

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


  // Data Layer
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<BlogRemoteDataSource>(() => BlogRemoteDataSourceImpl(sl()));


  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton<BlogUnwindRepository>(() => BlogRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton<GetAllUsers>(() => GetAllUsers(sl()));
  sl.registerLazySingleton<GetAllBlogs>(() => GetAllBlogs(sl()));

  // Cubit
  // sl.registerFactory(() => UserCubit(sl()));
  sl.registerFactory<BaseCubit<List<BlogEntity>>>(() => BaseCubit<List<BlogEntity>>(
    fetchData: () async {
      final result = await sl<GetAllBlogs>()(NoParams());
      return result.fold(
            (failure) => throw Exception(failure.message),
            (blogs) => blogs,
      );
    },
  ));

}