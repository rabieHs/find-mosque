// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/Features/prayer/data/datasources/remote_datasource.dart';
import 'package:find_mosques/Features/prayer/domain/repository/preyer_repository.dart';
import 'package:find_mosques/core/error/failure.dart';

import '../../../../core/error/exception.dart';
import '../../../../core/networks/network_info.dart';
import '../../domain/entities/prayer_times.dart';

class PrayerRepositoryImpl implements PrayerRepository {
  final PrayerRemoteDataSource remoteDatasource;
  final NetworkInfo networkInfo;
  PrayerRepositoryImpl({
    required this.remoteDatasource,
    required this.networkInfo,
  });
  @override
  Future<Either<Failure, PrayerTimes>> getPrayerTimes(
      String address, String date) async {
    if (await networkInfo.isConnected) {
      try {
        final response = await remoteDatasource.getPrayerTimes(address, date);
        return Right(response);
      } on ServerException catch (_) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
