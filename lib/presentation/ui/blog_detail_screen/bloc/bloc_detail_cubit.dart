import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_unwind_blog/domain/entities/blog_detail_entity.dart';
import 'package:the_unwind_blog/domain/usecase/get_blog_detail_usecase.dart';
import 'package:the_unwind_blog/untils/resource.dart';

class BlocDetailCubit extends Cubit<Resource<BlogDetailEntity>> {
  final GetBlogDetailUseCase _getBlogDetailUseCase;

  BlocDetailCubit(this._getBlogDetailUseCase) : super(const Loading());

  Future<void> getBlogDetail(int blogId) async {
    emit(const Loading());
    final result = await _getBlogDetailUseCase(blogId);

    result.fold(
          (failure) {
        print("❌ Error: ${failure.message}"); // 👈 In lỗi
        emit(Error(failure.message));
      },
          (data) {
        print("✅ Blog Loaded: ${data.title}"); // 👈 In thông tin blog
        emit(Success(data));
      },
    );
  }
}