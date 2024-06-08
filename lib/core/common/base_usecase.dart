import 'package:dartz/dartz.dart';
import 'package:find_mosques/core/error/failure.dart';

abstract class BaseUsecase<T, P> {
  Future<Either<Failure, T>> call(P parameter);
}
