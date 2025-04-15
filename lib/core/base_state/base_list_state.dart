abstract class BaseState<T> {}

class InitialState<T> extends BaseState<T> {}

class LoadingState<T> extends BaseState<T> {}

class SuccessState<T> extends BaseState<T> {
  final T data;
  SuccessState(this.data);
}

class ErrorState<T> extends BaseState<T> {
  final String message;
  ErrorState(this.message);
}