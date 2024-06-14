import 'package:find_mosques/Features/mosques/domain/entities/suggestion.dart';

class SuggestionModel extends Suggestion {
  const SuggestionModel({required super.name, required super.placeId});

  factory SuggestionModel.fromJson(Map<String, dynamic> json) {
    return SuggestionModel(
      name: json['description'],
      placeId: json['place_id'],
    );
  }
}
