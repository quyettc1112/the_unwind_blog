import 'package:dartz/dartz.dart';

import '../../core/error/failures.dart';
import '../entities/user_entity.dart';

abstract interface class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getAllUsers();
}