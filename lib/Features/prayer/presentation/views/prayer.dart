import 'package:find_mosques/Features/mosques/presentation/widgets/prayer_time_widget.dart';
import 'package:find_mosques/Features/prayer/domain/entities/prayer.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/constants/styles/paddings.dart';
import 'package:find_mosques/core/constants/styles/shapes.dart';
import 'package:find_mosques/core/constants/styles/text_styles.dart';
import 'package:find_mosques/core/extensions/screen_sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../mosques/presentation/widgets/shimmer_prayer_time_card.dart';
import '../controllers/bloc/prayer_bloc.dart';
import '../widgets/prayer_time_card.dart';

class PrayerScreen extends StatelessWidget {
  const PrayerScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final locale = AppLocalizations.of(context)!;
    BlocProvider.of<PrayerBloc>(context)
        .add(GetPrayerTimesEvent(context: context));
    return BlocBuilder<PrayerBloc, PrayerState>(
      builder: (context, state) {
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
                _buildPrayerTimesList(context, locale, state)
              ],
            ),
          ),
        );
      },
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

  Widget _buildPrayerTimesList(
      BuildContext context, AppLocalizations locale, PrayerState state) {
    if (state is LoadedPrayerState) {
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
                  final prayer = state.prayers[index];
                  return PrayerTimeCard(prayer: prayer);
                })
          ],
        ),
      );
    } else if (state is ErrorPrayerState) {
      return Center(
        child: ErrorWidget(Exception.new('error')),
      );
    } else {
      // Shimmer effect during loading
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
                itemCount: 5, // Number of shimmer items to show
                itemBuilder: (context, index) {
                  return const ShimmerPrayerTimeCard();
                })
          ],
        ),
      );
    }
  }
}
