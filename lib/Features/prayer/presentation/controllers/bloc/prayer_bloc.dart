// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:find_mosques/Features/prayer/domain/entities/prayer.dart';
import 'package:find_mosques/Features/prayer/domain/entities/prayer_times.dart';
import 'package:find_mosques/core/methods/maps_methods.dart';
import 'package:find_mosques/core/methods/prayer_methods.dart';
import 'package:find_mosques/core/methods/time_formatting.dart';

import '../../../../../core/parameters/prayer_times_parameters.dart';
import '../../../domain/usecases/get_prayer_times_usecase.dart';

part 'prayer_event.dart';
part 'prayer_state.dart';

class PrayerBloc extends Bloc<PrayerEvent, PrayerState> {
  final GetPrayerUsecase getPrayerUsecase;
  final MapsMethos mapsMethods;
  PrayerMethods prayerMethods;
  PrayerBloc(
    this.getPrayerUsecase,
    this.mapsMethods,
    this.prayerMethods,
  ) : super(PrayerInitial()) {
    on<GetPrayerTimesEvent>((event, emit) async {
      final locale = AppLocalizations.of(event.context)!;
      String address = await mapsMethods.getUserAddress();
      String todayDate = getFormattedDate();
      String tomorrowDate = getFormattedDate(offsetDays: 1);

      final todayParameters =
          PrayerTimesParameters(address: address, date: todayDate);
      final tomorrowParameters =
          PrayerTimesParameters(address: address, date: tomorrowDate);

      final todayResponse = await getPrayerUsecase(todayParameters);
      final tomorrowResponse = await getPrayerUsecase(tomorrowParameters);

      todayResponse.fold((error) => emit(ErrorPrayerState()), (todayPrayer) {
        tomorrowResponse.fold((error) => emit(ErrorPrayerState()),
            (tomorrowPrayerTimes) {
          List<Prayer> todayPrayers =
              prayerMethods.generatePrayerList(locale, todayPrayer);

          final nextPrayer = prayerMethods.getNextPrayer(todayPrayers);
          if (nextPrayer != null) {
            emit(LoadedPrayerState(
                prayers: todayPrayers, nextPrayer: nextPrayer));
          } else {
            final tomorrowPrayer =
                prayerMethods.generatePrayer(locale, tomorrowPrayerTimes, 0);
            emit(LoadedPrayerState(
                prayers: todayPrayers, nextPrayer: tomorrowPrayer!));
          }
        });
      });
    });

    // on<GetPrayerTimesEvent>((event, emit) async {
    //   final locale = AppLocalizations.of(event.context)!;
    //   String date = getFormattedDate();
    //   String tomorrowDate = getFormattedDate(offsetDays: 1);

    //   String address = await mapsMethods.getUserAddress();
    //   final parameters = PrayerTimesParameters(address: address, date: date);

    //   final response = await getPrayerUsecase(parameters);
    //   final tomorrowwResponse = await getPrayerUsecase(parameters);

    //   response.fold((l) => emit(ErrorPrayerState()), (prayer) async {
    //     List<Prayer> prayers = prayerMethods.generatePrayerList(locale, prayer);
    //     final nextPrayer = prayerMethods.getNextPrayer(prayers);
    //     if (nextPrayer != null) {
    //       emit(LoadedPrayerState(prayers: prayers, nextPrayer: nextPrayer));
    //     } else {
    //       final tomorrowResponse = await getPrayerUsecase(
    //           PrayerTimesParameters(address: address, date: tomorrowDate));

    //       tomorrowResponse.fold((l) => emit(ErrorPrayerState()), (prayer) {
    //         final tomorrowPrayer =
    //             prayerMethods.generatePrayer(locale, prayer, 0);
    //         emit(LoadedPrayerState(
    //             prayers: prayers, nextPrayer: tomorrowPrayer));
    //       });
    //     }
    //   });
    // });
  }
}
