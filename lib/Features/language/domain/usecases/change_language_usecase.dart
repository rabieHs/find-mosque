// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/Features/language/domain/repository/language_repository.dart';
import 'package:find_mosques/core/error/failure.dart';
import 'package:find_mosques/core/parameters/base_usecase.dart';

class ChangeLanguageUsecase extends BaseUsecase<Unit, String> {
  final LanguageRepository repository;
  ChangeLanguageUsecase({
    required this.repository,
  });
  @override
  Future<Either<Failure, Unit>> call(String parameter) async {
    return await repository.changeLanguage(parameter);
  }
}
