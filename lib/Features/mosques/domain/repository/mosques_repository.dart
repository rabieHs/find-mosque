import 'package:dartz/dartz.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/core/error/failure.dart';

abstract class MosquesRepository {
  Future<Either<Failure, List<Location>>> getAllMosques(
      double lat, double long);
}
