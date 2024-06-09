import '../error/failure.dart';

String mapFailureToMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return 'Server Error';
    case OfflineFailure:
      return 'Offline Failure';
    default:
      return 'Unexpected Error';
  }
}
