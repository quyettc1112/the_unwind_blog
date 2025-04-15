import 'package:dartz/dartz.dart';

import 'package:the_unwind_blog/core/error/failures.dart';
import 'package:the_unwind_blog/domain/repositories/blog_unwind_repository.dart';

import '../../core/usecase/usecase.dart';
import '../entities/blog_unwind_entity.dart';

class GetAllBlogs implements UseCase<List<BlogEntity>, NoParams> {
  final BlogUnwindRepository repository;

  GetAllBlogs(this.repository);

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async{
    return await repository.getBlogUnwindList();
  }

}