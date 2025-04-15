import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../error/failures.dart';
import 'base_list_state.dart';

class BaseCubit<T> extends Cubit<BaseState<T>> {
  final Future<T> Function() fetchData;

  BaseCubit({required this.fetchData}) : super(InitialState<T>());

  Future<void> loadData() async {
    try {
      emit(LoadingState<T>());
      final result = await fetchData();
      emit(SuccessState<T>(result));
    } catch (e) {
      emit(ErrorState<T>(e.toString()));
    }
  }
}