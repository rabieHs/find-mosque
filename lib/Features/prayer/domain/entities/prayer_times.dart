// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class PrayerTimes extends Equatable {
  final String fajr;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;
  const PrayerTimes({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  @override
  List<Object> get props => [fajr, dhuhr, asr, maghrib, isha];
}
