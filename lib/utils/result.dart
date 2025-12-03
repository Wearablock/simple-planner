/// 작업 결과를 나타내는 sealed 클래스
///
/// 성공 시 [Success], 실패 시 [Failure]를 반환합니다.
sealed class Result<T> {
  const Result();

  /// 성공 여부
  bool get isSuccess => this is Success<T>;

  /// 실패 여부
  bool get isFailure => this is Failure<T>;

  /// 성공 시 값을 반환, 실패 시 null 반환
  T? get valueOrNull => switch (this) {
        Success(value: final v) => v,
        Failure() => null,
      };

  /// 성공 시 값을 반환, 실패 시 기본값 반환
  T valueOr(T defaultValue) => valueOrNull ?? defaultValue;

  /// 결과를 변환
  Result<R> map<R>(R Function(T value) transform) => switch (this) {
        Success(value: final v) => Success(transform(v)),
        Failure(error: final e, stackTrace: final s) => Failure(e, s),
      };

  /// 성공/실패에 따라 다른 함수 실행
  R when<R>({
    required R Function(T value) success,
    required R Function(Object error, StackTrace? stackTrace) failure,
  }) =>
      switch (this) {
        Success(value: final v) => success(v),
        Failure(error: final e, stackTrace: final s) => failure(e, s),
      };
}

/// 성공 결과
final class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

/// 실패 결과
final class Failure<T> extends Result<T> {
  final Object error;
  final StackTrace? stackTrace;
  const Failure(this.error, [this.stackTrace]);
}

/// void 반환 작업용 성공 결과
const successVoid = Success<void>(null);
