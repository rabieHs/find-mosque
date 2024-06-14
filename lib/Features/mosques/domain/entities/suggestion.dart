// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Suggestion extends Equatable {
  final String name;
  final String placeId;
  const Suggestion({
    required this.name,
    required this.placeId,
  });

  @override
  List<Object> get props => [name, placeId];
}
