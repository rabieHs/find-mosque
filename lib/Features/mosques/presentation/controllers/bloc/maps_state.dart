part of 'maps_bloc.dart';

sealed class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object> get props => [];
}

final class MapsInitial extends MapsState {}

class InitializedMapsState extends MapsState {}
