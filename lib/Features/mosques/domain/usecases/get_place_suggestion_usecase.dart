// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:find_mosques/Features/mosques/domain/entities/suggestion.dart';
import 'package:find_mosques/Features/mosques/domain/repository/places_repository.dart';
import 'package:find_mosques/core/parameters/base_usecase.dart';
import 'package:find_mosques/core/error/failure.dart';
import 'package:find_mosques/core/parameters/suggestion_parameters.dart';

class GetPlaceSuggestionUsecase
    extends BaseUsecase<List<Suggestion>, SuggestionParameters> {
  final PlacesRepository repository;
  GetPlaceSuggestionUsecase({
    required this.repository,
  });
  @override
  Future<Either<Failure, List<Suggestion>>> call(
      SuggestionParameters parameter) async {
    return await repository.getPlacesSuggestion(
        parameter.query, parameter.country);
  }
}
