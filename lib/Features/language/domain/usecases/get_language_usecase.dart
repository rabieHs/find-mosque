// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/core/error/failure.dart';
import 'package:find_mosques/core/parameters/base_usecase.dart';
import 'package:find_mosques/core/parameters/no_parameters.dart';

import '../repository/language_repository.dart';

class GetLanguageUsecase extends BaseUsecase<String, NoParameters> {
  final LanguageRepository repository;
  GetLanguageUsecase({
    required this.repository,
  });

  @override
  Future<Either<Failure, String>> call(NoParameters parameter) async {
    return await repository.getLanguage();
  }
}
