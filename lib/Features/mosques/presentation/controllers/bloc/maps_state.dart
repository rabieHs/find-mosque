// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'maps_bloc.dart';

sealed class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object> get props => [];
}

final class MapsInitial extends MapsState {}

class InitializedCameraState extends MapsState {
  final CameraPosition cameraPosition;

  const InitializedCameraState({
    required this.cameraPosition,
  });

  @override
  List<Object> get props => [cameraPosition];
}

class MosquesLoadingState extends MapsState {}

class MosquesErrorState extends MapsState {
  final String message;
  const MosquesErrorState({required this.message});
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

class ShowMosqueInfoState extends MapsState {
  final Location location;
  const ShowMosqueInfoState(
    this.location,
  );
  @override
  List<Object> get props => [location];
}
