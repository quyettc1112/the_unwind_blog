import 'package:the_unwind_blog/domain/entities/blog_unwind_entity.dart';

import '../../core/usecase/base_usecase.dart';
import '../../untils/typedef.dart';
import '../repositories/blog_unwind_repository.dart';

class GetBlogsUseCase extends BaseUseCaseWithoutParams<List<BlogEntity>> {
  BlogUnwindRepository _blogUnwindRepository;
  GetBlogsUseCase(this._blogUnwindRepository);
  @override
  ResultFuture<List<BlogEntity>> call() async {
    return _blogUnwindRepository.getBlogs();
  }
}