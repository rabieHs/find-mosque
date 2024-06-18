// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/core/error/failure.dart';
import 'package:find_mosques/core/parameters/base_usecase.dart';
import 'package:find_mosques/core/parameters/no_parameters.dart';

import '../repository/landing_repository.dart';

class GetLandingUsecase extends BaseUsecase<String, NoParameters> {
  final LandingRepository repository;
  GetLandingUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(NoParameters parameter) async {
    return await repository.getLanding();
  }
}
