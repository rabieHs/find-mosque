import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../Features/prayer/domain/entities/prayer.dart';
import '../../Features/prayer/domain/entities/prayer_times.dart';

class PrayerMethods {
  List<Prayer> generatePrayerList(AppLocalizations locale, PrayerTimes prayer) {
    return List.generate(5, (index) {
      return generatePrayer(locale, prayer, index);
    });
  }

  Prayer generatePrayer(
      AppLocalizations locale, PrayerTimes prayer, int index) {
    return Prayer(
      name: getPrayerName(index, locale),
      time: getPrayerTime(index, prayer),
      image: getPrayerImage(index),
    );
  }

  String getPrayerImage(int index) {
    switch (index) {
      case 0:
        return "assets/icons/fajrmaghreb.png";
      case 1:
        return "assets/icons/duhr.png";
      case 2:
        return "assets/icons/asr.png";
      case 3:
        return "assets/icons/fajrmaghreb.png";
      default:
        return "assets/icons/isha.png";
    }
  }

  String getPrayerName(int index, AppLocalizations locale) {
    switch (index) {
      case 0:
        return locale.fajr;
      case 1:
        return locale.dhuhr;
      case 2:
        return locale.asr;
      case 3:
        return locale.maghrib;
      default:
        return locale.isha;
    }
  }

  String getPrayerTime(int index, PrayerTimes prayerTimes) {
    switch (index) {
      case 0:
        return prayerTimes.fajr;
      case 1:
        return prayerTimes.dhuhr;
      case 2:
        return prayerTimes.asr;
      case 3:
        return prayerTimes.maghrib;
      default:
        return prayerTimes.isha;
    }
  }

  Prayer? getNextPrayer(List<Prayer> prayers) {
    final now = DateTime.now();
    final dateFormat = DateFormat("HH:mm");

    for (final prayer in prayers) {
      try {
        final prayerTime = dateFormat.parse(prayer.time);
        final prayerDateTime = DateTime(
            now.year, now.month, now.day, prayerTime.hour, prayerTime.minute);

        if (prayerDateTime.isAfter(now)) {
          return prayer;
        }
      } catch (e) {
        print("Error parsing prayer time: $e");
      }
    }
    return null;
  }
}
