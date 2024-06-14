import 'package:dartz/dartz.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/Features/mosques/domain/entities/mosque.dart';
import 'package:find_mosques/Features/mosques/domain/entities/suggestion.dart';
import 'package:find_mosques/core/error/failure.dart';

abstract class PlacesRepository {
  Future<Either<Failure, List<Location>>> getAllMosques(
      double lat, double long);

  Future<Either<Failure, Mosque>> getMosqueInfo(Location location);
  Future<Either<Failure, Unit>> addMosqueInfo(Mosque mosque);
  Future<Either<Failure, List<Suggestion>>> getPlacesSuggestion(
      String query, String country);
  Future<Either<Failure, Location>> getPlaceLocationById(String id);
}
