part of 'mosque_bloc.dart';

abstract class MosqueState extends Equatable {
  const MosqueState();

  @override
  List<Object> get props => [];
}

final class MosqueInitial extends MosqueState {}

final class SuccessAddMosqueState extends MosqueState {}

final class SuccessGetMosqueState extends MosqueState {
  final Mosque mosque;
  const SuccessGetMosqueState({required this.mosque});
  @override
  List<Object> get props => [mosque];
}

final class ErrorAddMosqueState extends MosqueState {
  final String message;
  const ErrorAddMosqueState({required this.message});
  @override
  List<Object> get props => [message];
}

final class ErrorGetMosqueState extends MosqueState {
  final String message;
  const ErrorGetMosqueState({required this.message});
  @override
  List<Object> get props => [message];
}

class LoadingAddMosqueState extends MosqueState {
  const LoadingAddMosqueState();
  @override
  List<Object> get props => [];
}
