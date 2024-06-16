import 'package:find_mosques/Features/mosques/presentation/widgets/prayer_time_widget.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/constants/styles/paddings.dart';
import 'package:find_mosques/core/constants/styles/shapes.dart';
import 'package:find_mosques/core/constants/styles/text_styles.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Prayer extends StatelessWidget {
  const Prayer({super.key});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        gradient: gradientColo,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            _buildPrayerTimesList(context, locale)
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final locale = AppLocalizations.of(context)!;

    return Container(
      padding: defaultPadding,
      height: context.screenHeight() * 0.27,
      child: PrayerTimeWidget(locale: locale),
    );
  }

  Widget _buildPrayerTimesList(BuildContext context, AppLocalizations locale) {
    return Padding(
      padding: customPadding(0, 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(locale.nextPrayerTime,
              style: defaultTitleTextStyle.copyWith(
                  color: Colors.white, fontWeight: FontWeight.bold)),
          ListView.builder(
              primary: true,
              padding: customPadding(15, 0),
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                      contentPadding: customPadding(8, 30),
                      shape: customRoundedShape(15),
                      tileColor: Colors.white.withOpacity(0.3),
                      leading: Image.asset("assets/icons/fajrmaghreb.png",
                          width: 50, height: 50),
                      title: Text(
                        locale.fajr,
                        style: defaultTextStyle.copyWith(
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: Text(
                        "5:15",
                        style: defaultTextStyle,
                      )),
                );
              })
        ],
      ),
    );
  }
}
