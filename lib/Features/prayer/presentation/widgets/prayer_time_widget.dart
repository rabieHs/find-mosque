// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/Features/prayer/presentation/controllers/bloc/prayer_bloc.dart';
import 'package:find_mosques/core/widgets/next_prayer_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:http/http.dart';

import '../../../../core/constants/styles/text_styles.dart';
import '../../../../core/widgets/custom_icon_menu_button.dart';
import '../../domain/entities/prayer.dart';

class PrayerTimeWidget extends StatelessWidget {
  const PrayerTimeWidget({
    Key? key,
    required this.locale,
  }) : super(key: key);

  final AppLocalizations locale;

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PrayerBloc>(context)
        .add(GetPrayerTimesEvent(context: context));
    return BlocBuilder<PrayerBloc, PrayerState>(
      builder: (context, state) {
        print(state.runtimeType);
        if (state is LoadedPrayerState) {
          final prayer = state.nextPrayer;

          return _nextPrayerWidget(prayer);
        } else {
          return NextPrayerShimmerWidget();
        }
      },
    );
  }

  Container _nextPrayerWidget(Prayer prayer) {
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
                    prayer.image,
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
            prayer.time,
            style: largeTitleTextStyle.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(
            prayer.name,
            style: defaultTextStyle,
          )
        ],
      ),
    );
  }
}
