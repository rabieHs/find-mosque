part of 'luanch_bloc.dart';

abstract class LuanchState extends Equatable {
  const LuanchState();

  @override
  List<Object> get props => [];
}

final class LuanchInitial extends LuanchState {}

final class LuanchLoaded extends LuanchState {}
