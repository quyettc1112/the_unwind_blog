import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_unwind_blog/domain/usecase/get_blogs_usecase.dart';

import '../../../domain/entities/blog_unwind_entity.dart';
import '../../../untils/resource.dart';
class BlogCubit extends Cubit<Resource<BlogPaginatedEntity>> {
  final GetBlogsUseCase _getBlogsUseCase;

  BlogCubit(this._getBlogsUseCase) : super(const Loading());

  Future<void> getBlogs() async {
    emit(Loading()); // Không dùng const

    final result = await _getBlogsUseCase.call();

    result.fold(
          (failure) {
        print("📛 Emit Error: ${failure.message}"); // 👈 log lỗi
        emit(Error(failure.message));
      },
          (data) {
        print("📦 Emit Success with ${data.content.length} blogs"); // 👈 log thành công
        emit(Success(data));
      },
    );
  }
}
