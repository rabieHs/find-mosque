// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mosque_bloc.dart';

abstract class MosqueEvent extends Equatable {
  const MosqueEvent();

  @override
  List<Object> get props => [];
}

class AddMosqueInfoEvent extends MosqueEvent {
  BuildContext context;
  final String name;
  final Location location;
  final bool isManAndWomen;
  final bool isFridayPrayer;
  final bool isAvailable;
  final bool isTeaching;
  AddMosqueInfoEvent(
    this.context,
    this.name,
    this.location,
    this.isManAndWomen,
    this.isFridayPrayer,
    this.isAvailable,
    this.isTeaching,
  );
  @override
  List<Object> get props => [location];
}

class GetMosqueInfoEvent extends MosqueEvent {
  BuildContext context;

  final Location location;
  GetMosqueInfoEvent({
    required this.context,
    required this.location,
  });
  @override
  List<Object> get props => [location];
}
