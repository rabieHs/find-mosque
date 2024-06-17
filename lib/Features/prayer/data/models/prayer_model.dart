import 'dart:convert';

import 'package:find_mosques/Features/prayer/domain/entities/prayer_times.dart';

class PrayerModel extends PrayerTimes {
  const PrayerModel(
      {required super.fajr,
      required super.dhuhr,
      required super.asr,
      required super.maghrib,
      required super.isha});

  factory PrayerModel.fromMap(Map<String, dynamic> json) {
    return PrayerModel(
      fajr: json['data']['timings']['Fajr'],
      dhuhr: json['data']['timings']['Dhuhr'],
      asr: json['data']['timings']['Asr'],
      maghrib: json['data']['timings']['Maghrib'],
      isha: json['data']['timings']['Isha'],
    );
  }

  factory PrayerModel.fromJson(String json) {
    return PrayerModel.fromMap(jsonDecode(json));
  }
}
