import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_mosques/Features/language/domain/usecases/change_language_usecase.dart';
import 'package:find_mosques/Features/language/domain/usecases/get_language_usecase.dart';

import '../../../../../core/parameters/no_parameters.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  final GetLanguageUsecase getLanguageUsecase;
  final ChangeLanguageUsecase changeLanguageUsecase;
  String _languageCode = '';
  final _languageCodeController = StreamController<String>.broadcast();

  String get languageCode => _languageCode;
  Stream<String> get languageCodeStream => _languageCodeController.stream;
  LanguageBloc(this.getLanguageUsecase, this.changeLanguageUsecase)
      : super(LanguageInitial()) {
    on<ChangeLanguageEvent>((event, emit) async {
      emit(LoadingLanguage());
      _languageCode = event.languageCode;
      _languageCodeController.sink.add(_languageCode);
      final response = await changeLanguageUsecase(event.languageCode);
      response.fold((l) => emit(const ErrorLanguageState(message: "")),
          (r) => emit(LanguageLoaded(languageCode: event.languageCode)));
    });

    on<GetLanguageEvent>((event, emit) async {
      emit(LoadingLanguage());
      final response = await getLanguageUsecase(NoParameters());
      response.fold((l) => emit(const ErrorLanguageState(message: "")),
          (r) => _languageCode = r);
    });
  }

  @override
  Future<void> close() {
    _languageCodeController.close();
    return super.close();
  }
}
