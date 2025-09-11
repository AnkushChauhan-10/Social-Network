abstract class UseCaseWithParam<T, P> {
  const UseCaseWithParam();

  T call(P param);
}

abstract class UseCaseWithOutParam<T> {
  const UseCaseWithOutParam();

  T call();
}
