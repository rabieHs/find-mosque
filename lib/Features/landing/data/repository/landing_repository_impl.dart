// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:find_mosques/Features/landing/domain/repository/landing_repository.dart';

import 'package:find_mosques/Features/language/data/datasources/local_datasource.dart';
import 'package:find_mosques/core/error/failure.dart';

import '../datasources/local_datasource.dart';

class LandingRepositoryImpl implements LandingRepository {
  final LocalLandingDatasourceImpl datasource;
  LandingRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, Unit>> saveLanding() async {
    try {
      final response = await datasource.saveLanding();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getLanding() async {
    try {
      final response = await datasource.getLanding();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
