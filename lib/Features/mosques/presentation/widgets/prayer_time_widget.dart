import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/constants/styles/text_styles.dart';
import '../../../../core/widgets/custom_icon_menu_button.dart';

class PrayerTimeWidget extends StatelessWidget {
  const PrayerTimeWidget({
    super.key,
    required this.locale,
  });

  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                  child: Align(
                      alignment: locale.localeName == "ar"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: const CustomIconMenuButton())),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.asset(
                    "assets/icons/fajrmaghreb.png",
                    width: 30,
                    height: 30,
                  ),
                ),
              ),
              Expanded(child: Container())
            ],
          ),
          Text(
            locale.nextPrayerTime,
            style: defaultTextStyle,
          ),
          Text(
            " AM 5:15",
            style: largeTitleTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            locale.fajrPrayer,
            style: defaultTextStyle,
          )
        ],
      ),
    );
  }
}
