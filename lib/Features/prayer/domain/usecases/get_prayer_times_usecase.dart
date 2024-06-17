// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/core/error/failure.dart';
import 'package:find_mosques/core/parameters/base_usecase.dart';
import 'package:find_mosques/core/parameters/prayer_times_parameters.dart';

import '../entities/prayer_times.dart';
import '../repository/preyer_repository.dart';

class GetPrayerUsecase extends BaseUsecase<PrayerTimes, PrayerTimesParameters> {
  final PrayerRepository repository;
  GetPrayerUsecase({
    required this.repository,
  });
  @override
  Future<Either<Failure, PrayerTimes>> call(
      PrayerTimesParameters parameter) async {
    return await repository.getPrayerTimes(parameter.address, parameter.date);
  }
}
