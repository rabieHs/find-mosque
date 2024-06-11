// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'mosque_bloc.dart';

abstract class MosqueEvent extends Equatable {
  const MosqueEvent();

  @override
  List<Object> get props => [];
}

class AddMosqueInfoEvent extends MosqueEvent {
  final String name;
  final Location location;
  final bool isManAndWomen;
  final bool isFridayPrayer;
  final bool isAvailable;
  final bool isTeaching;
  const AddMosqueInfoEvent(
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
  final Location location;
  const GetMosqueInfoEvent({required this.location});
  @override
  List<Object> get props => [location];
}
