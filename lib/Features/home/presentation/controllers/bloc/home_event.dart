// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class closeDrawerEvent extends HomeEvent {}

class openDrawerEvent extends HomeEvent {
  final String languageCode;
  const openDrawerEvent({
    required this.languageCode,
  });
  @override
  List<Object> get props => [languageCode];
}

class ChangePageEvent extends HomeEvent {
  final int itemId;
  const ChangePageEvent({
    required this.itemId,
  });
}
