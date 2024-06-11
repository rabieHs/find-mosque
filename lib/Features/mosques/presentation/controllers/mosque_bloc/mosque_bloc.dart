// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_mosques/Features/mosques/domain/entities/mosque.dart';

import 'package:find_mosques/Features/mosques/domain/usecases/add_mosque_info_usecase.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_mosque_info_usecase.dart';
import 'package:find_mosques/core/methods/error_handler.dart';

import '../../../domain/entities/location.dart';

part 'mosque_event.dart';
part 'mosque_state.dart';

class MosqueBloc extends Bloc<MosqueEvent, MosqueState> {
  final GetMosqueInfoUsecase getMosqueInfoUsecase;
  final AddMosqueInfoUsecase addMosqueInfoUsecase;

  MosqueBloc(
    this.getMosqueInfoUsecase,
    this.addMosqueInfoUsecase,
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
        (l) => emit(ErrorAddMosqueState(message: mapFailureToMessage(l))),
        (r) => emit(SuccessAddMosqueState()),
      );
    });
    on<GetMosqueInfoEvent>((event, emit) async {
      emit(LoadingAddMosqueState());

      final response = await getMosqueInfoUsecase(event.location);
      response.fold(
        (l) => emit(ErrorAddMosqueState(message: mapFailureToMessage(l))),
        (r) => emit(SuccessGetMosqueState(mosque: r)),
      );
    });
  }
}
