
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'core/constants/app_url.dart';
import 'core/network/interceptors/logging_interceptor.dart';
import 'data/datasource/user_remote_data_source.dart';
import 'data/repositories/user_repository.dart';
import 'domain/repository/user_repository.dart';
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

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  // Use Cases
  sl.registerLazySingleton<GetAllUsers>(() => GetAllUsers(sl()));

  // Cubit
  // sl.registerFactory(() => UserCubit(sl()));

}