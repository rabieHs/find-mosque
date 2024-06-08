// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/Features/mosques/data/datasources/remote/remote_datasource.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/Features/mosques/domain/repository/mosques_repository.dart';
import 'package:find_mosques/core/error/exception.dart';
import 'package:find_mosques/core/error/failure.dart';
import 'package:find_mosques/core/networks/network_info.dart';

class MosquesRepositoryImpl implements MosquesRepository {
  final MosquesRemoteDatasource remoteDatasource;
  final NetworkInfo networkInfo;
  MosquesRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Location>>> getAllMosques(
      double lat, double long) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getAllMosques(lat, long);
        return Right(response);
      } on ServerException catch (e) {
        print(e);
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
