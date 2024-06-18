import 'package:dartz/dartz.dart';
import 'package:find_mosques/core/error/failure.dart';

abstract class LandingRepository {
  Future<Either<Failure, Unit>> saveLanding();
  Future<Either<Failure, String>> getLanding();
}
