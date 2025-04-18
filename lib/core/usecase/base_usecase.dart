
import '../../untils/typedef.dart';

abstract class BaseUseCaseWithParam<Out, In> {
  const BaseUseCaseWithParam();

  ResultFuture<Out> call(In input);
}

abstract class BaseUseCaseWithoutParams<Out> {
  BaseUseCaseWithoutParams();
  ResultFuture<Out> call();
}
