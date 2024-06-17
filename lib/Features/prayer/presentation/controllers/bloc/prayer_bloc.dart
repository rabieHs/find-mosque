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
      String date = getFormattedDate();
      String address = await mapsMethods.getUserAddress();
      final parameters = PrayerTimesParameters(address: address, date: date);

      final response = await getPrayerUsecase(parameters);
      response.fold((l) => emit(ErrorPrayerState()), (prayer) {
        List<Prayer> prayers = List.generate(5, (index) {
          return Prayer(
            name: prayerMethods.getPrayerName(index, locale),
            time: prayerMethods.getPrayerTime(index, prayer),
            image: prayerMethods.getPrayerImage(index),
          );
        });

        emit(LoadedPrayerState(prayers: prayers));
      });
    });
  }
}
