// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';

import '../../Features/mosques/presentation/controllers/mosque_bloc/mosque_bloc.dart';
import '../error/failure.dart';

class ErrorHandler {
  String mapFailureToMessage(Failure failure, BuildContext context) {
    final AppLocalizations locale = AppLocalizations.of(context)!;
    switch (failure.runtimeType) {
      case ServerFailure:
        return locale.errorOccurred;
      case OfflineFailure:
        return locale.youAreOffline;
      default:
        return locale.errorOccurred;
    }
  }

  MosqueState handeMosqueState(Failure failure, BuildContext context) {
    switch (failure.runtimeType) {
      case OfflineFailure || ServerFailure:
        return ErrorGetMosqueState(
            message: mapFailureToMessage(failure, context));
      default:
        return MosqueDataEmtyState();
    }
  }

  MapsState handeSuggestionState(Failure failure, BuildContext context) {
    print("handler failure: ${failure.runtimeType}");
    switch (failure.runtimeType) {
      case OfflineFailure || ServerFailure:
        return ErrorSuggestionsState(
            message: mapFailureToMessage(failure, context));
      default:
        return EmptySuggestionsState();
    }
  }
}
