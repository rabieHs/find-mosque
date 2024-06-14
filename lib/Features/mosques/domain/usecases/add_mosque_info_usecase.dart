// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/Features/mosques/domain/entities/mosque.dart';
import 'package:find_mosques/core/parameters/base_usecase.dart';
import 'package:find_mosques/core/error/failure.dart';

import '../repository/places_repository.dart';

class AddMosqueInfoUsecase extends BaseUsecase<Unit, Mosque> {
  final PlacesRepository repository;
  AddMosqueInfoUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Unit>> call(Mosque parameter) async {
    return await repository.addMosqueInfo(parameter);
  }
}
