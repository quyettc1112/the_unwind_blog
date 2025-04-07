import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecase/get_all_users.dart';
import '../../core/usecase/usecase.dart';
import '../../core/error/failures.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final GetAllUsers getAllUsers;

  UserCubit(this.getAllUsers) : super(UserInitial());

  void fetchUsers() async {
    emit(UserLoading()); // Khi bắt đầu fetch dữ liệu, chuyển sang trạng thái loading.

    final result = await getAllUsers(NoParams());  // Gọi UseCase, không cần truyền thêm repository.

    result.fold(
          (failure) {
        emit(UserError(failure.message)); // Nếu có lỗi, emit trạng thái lỗi.
      },
          (users) {
        emit(UserLoaded(users)); // Nếu thành công, emit trạng thái đã tải xong với danh sách người dùng.
      },
    );
  }
}
