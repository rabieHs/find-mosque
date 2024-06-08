// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'maps_bloc.dart';

abstract class MapsEvent extends Equatable {
  const MapsEvent();

  @override
  List<Object> get props => [];
}

class InitializeMapsEvent extends MapsEvent {
  final GoogleMapController controller;
  const InitializeMapsEvent({
    required this.controller,
  });
  @override
  List<Object> get props => [controller];
}
