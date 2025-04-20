import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_unwind_blog/domain/usecase/get_blogs_usecase.dart';

import '../../../data/dto/get_blogs_params.dart';
import '../../../domain/entities/blog_unwind_entity.dart';
import '../../../untils/resource.dart';

class BlogCubit extends Cubit<Resource<BlogPaginatedEntity>> {
  final GetBlogsUseCase _getBlogsUseCase;
  int? _totalPages;

  BlogCubit(this._getBlogsUseCase) : super(const Loading());

  /// Gọi khi mở màn đầu tiên (nếu vẫn muốn show UI bằng state)
  Future<void> getBlogs({
    required int pageNo,
    required int pageSize,
    String? title,
    int? categoryId,
  }) async {
    emit(const Loading());

    final result = await _getBlogsUseCase.call(
      GetBlogsParams(
        pageNo: pageNo,
        pageSize: pageSize,
        title: title,
        categoryId: categoryId,
      ),
    );

    result.fold(
          (failure) {
        print("📛 Emit Error: ${failure.message}");
        emit(Error(failure.message));
      },
          (data) {
        print("📦 Emit Success with ${data.content.length} blogs");
        emit(Success(data));
      },
    );
  }

  /// Gọi từ UI sử dụng `infinite_scroll_pagination`
  Future<BlogPaginatedEntity?> fetchBlogPage(
      int pageNo,
      int pageSize, {
        String? title,
        int? categoryId,
      }) async {
    final result = await _getBlogsUseCase.call(
      GetBlogsParams(
        pageNo: pageNo,
        pageSize: pageSize,
        title: title,
        categoryId: categoryId,
      ),
    );

    return result.fold(
          (failure) {
        print("📛 Load error: ${failure.message}");
        return null;
      },
          (data) {
        print("📦 Load page $pageNo: ${data.content.length} blogs");
        return data;
      },
    );
  }
}