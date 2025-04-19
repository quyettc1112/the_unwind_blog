
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
  R when<R>({
    required R Function() onLoading,
    required R Function(String message) onError,
    required R Function(T data) onSuccess,
  }) {
    if (this is Loading<T>) {
      return onLoading();
    } else if (this is Error<T>) {
      return onError((this as Error).message);
    } else if (this is Success<T>) {
      return onSuccess((this as Success<T>).data);
    } else {
      throw Exception("Unhandled Resource state");
    }
  }
}

