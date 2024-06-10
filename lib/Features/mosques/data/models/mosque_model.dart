import 'package:find_mosques/Features/mosques/domain/entities/mosque.dart';

class MosqueModel extends Mosque {
  MosqueModel(
      {required super.name,
      required super.location,
      required super.isManAndWomen,
      required super.isFridayPrayer,
      required super.isAvailable,
      required super.isTeaching,
      super.distance,
      super.time});

  factory MosqueModel.fromMap(Map<String, dynamic> json) {
    return MosqueModel(
      name: json['name'],
      location: json['location'],
      isManAndWomen: json['isManAndWomen'],
      isFridayPrayer: json['isFridayPrayer'],
      isAvailable: json['isAvailable'],
      isTeaching: json['isTeaching'],
    );
  }

  factory MosqueModel.fromEntity(Mosque mosque) {
    return MosqueModel(
      name: mosque.name,
      location: mosque.location,
      isManAndWomen: mosque.isManAndWomen,
      isFridayPrayer: mosque.isFridayPrayer,
      isAvailable: mosque.isAvailable,
      isTeaching: mosque.isTeaching,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'location': location,
      'isManAndWomen': isManAndWomen,
      'isFridayPrayer': isFridayPrayer,
      'isAvailable': isAvailable,
      'isTeaching': isTeaching,
    };
  }
}
