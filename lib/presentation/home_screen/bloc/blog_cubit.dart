import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_unwind_blog/domain/usecase/get_blogs_usecase.dart';

import '../../state_renderer/state_render_impl.dart';
import '../../state_renderer/state_renderer.dart';

class BlogCubit extends Cubit<FlowState> {
  BlogCubit({required GetBlogsUseCase getUsersUseCase}): _getBlogsUseCase = getUsersUseCase,
        super(InitalState());

  final GetBlogsUseCase _getBlogsUseCase;

  Future<void> getBlogs() async {
    emit(LoadingState(
        stateRendererType: StateRendererType.POPUP_LOADING_STATE,
        message: "Loading...."));

    try {
      final result = await _getBlogsUseCase.call();

      result.fold((failure) {
        emit(ErrorState(
            stateRendererType: StateRendererType.POPUP_ERROR_STATE,
            message: "Hello Failure"));
      }, (users) {
        emit(ContentState(users));
      });
    } catch (error) {
      emit(ErrorState(
          stateRendererType: StateRendererType.POPUP_ERROR_STATE,
          message: "Hello Failure $error"));
    }
  }
}