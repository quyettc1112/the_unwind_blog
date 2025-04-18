import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';

import '../../core/usecase/base_usecase.dart';
import '../../data/models/blog_paginated_model.dart';
import '../../untils/typedef.dart';
import '../repositories/blog_unwind_repository.dart';

class GetBlogsUseCase extends BaseUseCaseWithoutParams<BlogPaginatedEntity> {
  BlogUnwindRepository _blogUnwindRepository;
  GetBlogsUseCase(this._blogUnwindRepository);
  @override
  ResultFuture<BlogPaginatedEntity> call() async {
    return _blogUnwindRepository.getBlogs();
  }
}