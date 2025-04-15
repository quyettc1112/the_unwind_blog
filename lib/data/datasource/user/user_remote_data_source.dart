import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../models/user_model.dart';


abstract interface class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsers();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final response = await dio.get('user');
      return (response.data as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } on DioException catch (e) {
      throw ServerException.fromDioException(e);
    } catch (e) {
      throw ServerException('Something went wrong!');
    }
  }
}
