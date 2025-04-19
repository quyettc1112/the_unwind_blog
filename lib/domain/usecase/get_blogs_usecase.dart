import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';

import '../../core/usecase/base_usecase.dart';
import '../../data/dto/get_blogs_params.dart';
import '../../data/models/blog_paginated_model.dart';
import '../../untils/typedef.dart';
import '../repositories/blog_unwind_repository.dart';

class GetBlogsUseCase extends BaseUseCaseWithParam<BlogPaginatedEntity, GetBlogsParams> {
  final BlogUnwindRepository _blogUnwindRepository;

  GetBlogsUseCase(this._blogUnwindRepository);

  @override
  ResultFuture<BlogPaginatedEntity> call(GetBlogsParams input) {
    return _blogUnwindRepository.getBlogs(
      pageNo: input.pageNo,
      pageSize: input.pageSize,
      title: input.title,
      categoryId: input.categoryId,
    );
  }
}