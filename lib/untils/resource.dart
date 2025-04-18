
abstract class Resource<T> {
  const Resource();
}

class Loading<T> extends Resource<T> {
  const Loading();
}

class Success<T> extends Resource<T> {
  final T data;
  const Success(this.data);
}

class Error<T> extends Resource<T> {
  final String message;
  const Error(this.message);
}

/// Extension method for clean pattern matching
extension ResourceExtension<T> on Resource<T> {
  void when({
    required void Function() onLoading,
    required void Function(T data) onSuccess,
    required void Function(String message) onError,
  }) {
    if (this is Loading<T>) {
      onLoading();
    } else if (this is Success<T>) {
      onSuccess((this as Success<T>).data);
    } else if (this is Error<T>) {
      onError((this as Error<T>).message);
    }
  }

  void maybeWhen({
    void Function()? onLoading,
    void Function(T data)? onSuccess,
    void Function(String message)? onError,
    required void Function() orElse,
  }) {
    if (this is Loading<T> && onLoading != null) {
      onLoading();
    } else if (this is Success<T> && onSuccess != null) {
      onSuccess((this as Success<T>).data);
    } else if (this is Error<T> && onError != null) {
      onError((this as Error<T>).message);
    } else {
      orElse();
    }
  }

  void whenOrNull({
    void Function()? onLoading,
    void Function(T data)? onSuccess,
    void Function(String message)? onError,
  }) {
    if (this is Loading<T>) {
      onLoading?.call();
    } else if (this is Success<T>) {
      onSuccess?.call((this as Success<T>).data);
    } else if (this is Error<T>) {
      onError?.call((this as Error<T>).message);
    }
  }
}
