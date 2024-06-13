import '../../Features/mosques/presentation/controllers/mosque_bloc/mosque_bloc.dart';
import '../error/failure.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

String mapFailureToMessage(Failure failure, AppLocalizations locale) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return locale.errorOccurred;
    case OfflineFailure:
      return locale.youAreOffline;
    default:
      return locale.errorOccurred;
  }
}

MosqueState handeMosqueState(Failure failure, AppLocalizations locale) {
  print(failure.runtimeType);
  switch (failure.runtimeType) {
    case OfflineFailure || ServerFailure:
      return ErrorGetMosqueState(message: mapFailureToMessage(failure, locale));
    default:
      return MosqueDataEmtyState();
  }
}
