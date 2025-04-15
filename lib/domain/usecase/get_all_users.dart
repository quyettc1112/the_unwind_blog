import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';
import '../repositories/user_repository.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';


class GetAllUsers implements UseCase<List<UserEntity>, NoParams> {
  final UserRepository repository;

  GetAllUsers(this.repository);

  @override
  Future<Either<Failure, List<UserEntity>>> call(NoParams params) async {
    return await repository.getAllUsers();
  }
}