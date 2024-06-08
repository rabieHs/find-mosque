// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Location extends Equatable {
  final String id;
  final double latitude;
  final double longitude;
  final String name;
  const Location({
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.name,
  });

  @override
  List<Object?> get props => [];
}
