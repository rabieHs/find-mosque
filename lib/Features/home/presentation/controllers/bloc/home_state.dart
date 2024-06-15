part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

final class HomeInitial extends HomeState {}

final class DrawerOpenedState extends HomeState {
  final double xOffset;
  final double yOffset;
  final double scaleFoctor;
  final double shoadowxOffset;
  final double shoadowyOffset;
  final double shoadowscaleFoctor;

  const DrawerOpenedState({
    required this.xOffset,
    required this.yOffset,
    required this.scaleFoctor,
    required this.shoadowxOffset,
    required this.shoadowyOffset,
    required this.shoadowscaleFoctor,
  });
  @override
  List<Object> get props => [
        xOffset,
        yOffset,
        scaleFoctor,
      ];
}

final class DrawerClosedstate extends HomeState {
  final double xOffset;
  final double yOffset;
  final double scaleFoctor;

  const DrawerClosedstate({
    required this.xOffset,
    required this.yOffset,
    required this.scaleFoctor,
  });
  @override
  List<Object> get props => [
        xOffset,
        yOffset,
        scaleFoctor,
      ];
}
