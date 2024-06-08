part of 'luanch_bloc.dart';

abstract class LuanchEvent extends Equatable {
  const LuanchEvent();

  @override
  List<Object> get props => [];
}

class StartSplashEvent extends LuanchEvent {}
