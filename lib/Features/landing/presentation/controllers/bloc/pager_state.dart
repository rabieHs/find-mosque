// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pager_bloc.dart';

abstract class PagerState extends Equatable {
  const PagerState();

  @override
  List<Object> get props => [];
}

final class PagerInitial extends PagerState {}

class ChangePageState extends PagerState {
  int index;
  double progress;
  ChangePageState({required this.index, required this.progress});
  @override
  List<Object> get props => [index, progress];
}

class NavigatePageState extends PagerState {}
