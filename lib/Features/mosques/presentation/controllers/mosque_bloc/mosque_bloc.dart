// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_mosques/Features/mosques/domain/entities/mosque.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/add_mosque_info_usecase.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_mosque_info_usecase.dart';
import 'package:find_mosques/core/methods/error_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/entities/location.dart';

part 'mosque_event.dart';
part 'mosque_state.dart';

class MosqueBloc extends Bloc<MosqueEvent, MosqueState> {
  final GetMosqueInfoUsecase getMosqueInfoUsecase;
  final AddMosqueInfoUsecase addMosqueInfoUsecase;
  final ErrorHandler errorHandler;

  MosqueBloc(
    this.getMosqueInfoUsecase,
    this.addMosqueInfoUsecase,
    this.errorHandler,
  ) : super(MosqueInitial()) {
    on<AddMosqueInfoEvent>((event, emit) async {
      emit(LoadingAddMosqueState());
      final Mosque mosque = Mosque(
        name: event.name.isEmpty ? event.location.name : event.name,
        location: event.location,
        isManAndWomen: event.isManAndWomen,
        isFridayPrayer: event.isFridayPrayer,
        isAvailable: event.isAvailable,
        isTeaching: event.isTeaching,
      );
      final response = await addMosqueInfoUsecase(mosque);
      response.fold(
        (l) => emit(ErrorAddMosqueState(
            message: errorHandler.mapFailureToMessage(l, event.context))),
        (r) => emit(SuccessAddMosqueState()),
      );
    });
    on<GetMosqueInfoEvent>((event, emit) async {
      emit(LoadingGetMosqueInfoState());

      final response = await getMosqueInfoUsecase(event.location);
      response.fold(
        (l) {
          print("bloc runtimeType: ${l.runtimeType}");
          emit(errorHandler.handeMosqueState(l, event.context));
        },
        (r) => emit(SuccessGetMosqueState(mosque: r)),
      );
    });
  }
}
