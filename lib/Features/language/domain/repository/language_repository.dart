import 'package:dartz/dartz.dart';
import 'package:find_mosques/core/error/failure.dart';

abstract class LanguageRepository {
  Future<Either<Failure, Unit>> changeLanguage(String languageCode);
  Future<Either<Failure, String>> getLanguage();
}
