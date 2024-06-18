// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/Features/language/data/datasources/local_datasource.dart';
import 'package:find_mosques/Features/language/domain/repository/language_repository.dart';
import 'package:find_mosques/core/error/failure.dart';

class LanguageRepositoryImpl implements LanguageRepository {
  final LocalLanguageSatasource datasource;
  LanguageRepositoryImpl({
    required this.datasource,
  });

  @override
  Future<Either<Failure, Unit>> changeLanguage(String languageCode) async {
    try {
      final response = await datasource.changeLanguage(languageCode);
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getLanguage() async {
    try {
      final response = await datasource.getLanguage();
      return Right(response);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}
