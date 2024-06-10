import 'dart:convert';

import 'package:find_mosques/Features/mosques/domain/entities/location.dart';

class LocationModel extends Location {
  const LocationModel(
      {required super.id,
      required super.latitude,
      required super.longitude,
      required super.name});

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      id: map['place_id'],
      latitude: map['geometry']['location']['lat'],
      longitude: map['geometry']['location']['lng'],
      name: map['name'],
    );
  }

  factory LocationModel.fromJson(String json) =>
      LocationModel.fromMap(jsonDecode(json));

  factory LocationModel.fromEntity(Location location) {
    return LocationModel(
      id: location.id,
      latitude: location.latitude,
      longitude: location.longitude,
      name: location.name,
    );
  }
}
