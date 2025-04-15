import '../../core/network/connection_checker.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasource/user/user_local_data_source.dart';
import '../datasource/user/user_remote_data_source.dart';

import 'package:dartz/dartz.dart';

import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../core/network/connection_checker.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers() async {
    try {
      final users = await remoteDataSource.getAllUsers();
      return Right(users);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    } catch (e) {
      return Left(Failure('An unexpected error occurred'));
    }
  }

}

