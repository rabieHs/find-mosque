// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/Features/mosques/domain/entities/mosque.dart';
import 'package:find_mosques/core/common/base_usecase.dart';
import 'package:find_mosques/core/error/failure.dart';

import '../repository/mosques_repository.dart';

class GetMosqueInfoUsecase extends BaseUsecase<Mosque, Location> {
  final MosquesRepository repository;
  GetMosqueInfoUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, Mosque>> call(Location parameter) async {
    return await repository.getMosqueInfo(parameter);
  }
}
