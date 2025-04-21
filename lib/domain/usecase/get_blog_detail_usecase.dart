import 'package:the_unwind_blog/domain/entities/blog_detail_entity.dart';
import 'package:the_unwind_blog/untils/typedef.dart';

import '../../core/usecase/base_usecase.dart';
import '../repositories/blog_unwind_repository.dart';

class GetBlogDetailUseCase implements BaseUseCaseWithParam<BlogDetailEntity, int> {
  final BlogUnwindRepository _blogUnwindRepository;
  GetBlogDetailUseCase(this._blogUnwindRepository);
  @override
  ResultFuture<BlogDetailEntity> call(int input) {
    return _blogUnwindRepository.getBlogDetail(input);
  }
}