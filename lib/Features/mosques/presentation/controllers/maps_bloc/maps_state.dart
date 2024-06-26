// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'maps_bloc.dart';

sealed class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object> get props => [];
}

final class MapsInitial extends MapsState {}

class InitializedMapsState extends MapsState {
  const InitializedMapsState();

  @override
  List<Object> get props => [];
}

class MosquesLoadingState extends MapsState {}

class MosquesLocationErrorState extends MapsState {
  final String message;
  const MosquesLocationErrorState({required this.message});
  @override
  List<Object> get props => [message];
}

class MosquesLoadedState extends MapsState {
  final List<Location> mosques;
  const MosquesLoadedState({
    required this.mosques,
  });
  @override
  List<Object> get props => [mosques];
}

class LoadingMosqueInfoState extends MapsState {
  const LoadingMosqueInfoState();
  @override
  List<Object> get props => [];
}

class ShowMosqueLocationState extends MapsState {
  final Location location;
  const ShowMosqueLocationState(
    this.location,
  );
  @override
  List<Object> get props => [location];
}

class LoadingGetRouteInfoState extends MapsState {}

class SuccessGetRouteInfoState extends MapsState {
  double distance;
  double estimatedTime;
  String street;
  SuccessGetRouteInfoState({
    required this.street,
    required this.distance,
    required this.estimatedTime,
  });
  @override
  List<Object> get props => [distance, estimatedTime];
}

class SuccessNavigateState extends MapsState {}

class CancelNavigateState extends MapsState {}

class EmptySuggestionsState extends MapsState {}

class LoadingSuggestionsState extends MapsState {}

class ErrorSuggestionsState extends MapsState {
  final String message;
  const ErrorSuggestionsState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class LoadedSuggestionsState extends MapsState {
  final List<Suggestion> suggestions;
  const LoadedSuggestionsState({
    required this.suggestions,
  });
  @override
  List<Object> get props => [suggestions];
}

class ErrorMovingCameraToSearchedPlaceState extends MapsState {
  final String message;
  const ErrorMovingCameraToSearchedPlaceState({
    required this.message,
  });
  @override
  List<Object> get props => [message];
}

class SuccessMovingCameraToSearchedPlaceState extends MapsState {}
