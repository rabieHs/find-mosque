import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/styles/text_styles.dart';

class PrayerTimeWidget extends StatelessWidget {
  const PrayerTimeWidget({
    super.key,
    required this.locale,
  });

  final AppLocalizations? locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/icons/fajrmaghreb.png",
            width: 55,
            height: 55,
          ),
          Text(
            locale!.nextPrayerTime,
            style: defaultTextStyle,
          ),
          Text(
            " AM 5:15",
            style: largeTitleTextStyle,
          ),
          Text(
            locale!.fajrPrayer,
            style: defaultTextStyle,
          )
        ],
      ),
    );
  }
}
