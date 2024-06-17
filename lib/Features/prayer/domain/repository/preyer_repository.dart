import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/prayer_times.dart';

abstract class PrayerRepository {
  Future<Either<Failure, PrayerTimes>> getPrayerTimes(
      String address, String date);
}
