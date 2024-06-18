// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:find_mosques/Features/landing/domain/repository/landing_repository.dart';

import 'package:find_mosques/core/error/failure.dart';
import 'package:find_mosques/core/parameters/base_usecase.dart';
import 'package:find_mosques/core/parameters/no_parameters.dart';

class SaveLandingUsecase extends BaseUsecase<Unit, NoParameters> {
  final LandingRepository repository;
  SaveLandingUsecase({
    required this.repository,
  });
  @override
  Future<Either<Failure, Unit>> call(NoParameters parameter) async {
    return await repository.saveLanding();
  }
}
