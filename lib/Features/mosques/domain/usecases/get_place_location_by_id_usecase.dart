// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/Features/mosques/domain/repository/places_repository.dart';
import 'package:find_mosques/core/error/failure.dart';
import 'package:find_mosques/core/parameters/base_usecase.dart';

class GetPlaceLocationByIdUsecase extends BaseUsecase<Location, String> {
  final PlacesRepository repository;
  GetPlaceLocationByIdUsecase({
    required this.repository,
  });
  @override
  Future<Either<Failure, Location>> call(String parameter) async {
    return await repository.getPlaceLocationById(parameter);
  }
}
