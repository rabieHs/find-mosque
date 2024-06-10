// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

import 'package:find_mosques/Features/mosques/domain/entities/location.dart';

class Mosque extends Equatable {
  final String name;
  final Location location;
  final bool isManAndWomen;
  final bool isFridayPrayer;
  final bool isAvailable;
  final bool isTeaching;
  double? distance;
  String? time;
  Mosque({
    required this.name,
    required this.location,
    required this.isManAndWomen,
    required this.isFridayPrayer,
    required this.isAvailable,
    required this.isTeaching,
    this.distance,
    this.time,
  });

  @override
  List<Object?> get props => [
        name,
        location,
        isManAndWomen,
        isFridayPrayer,
        isAvailable,
        isTeaching,
        distance,
        time,
      ];
}
