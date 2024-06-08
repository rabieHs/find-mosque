// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pager_bloc.dart';

sealed class PagerEvent extends Equatable {
  const PagerEvent();

  @override
  List<Object> get props => [];
}

class NavigateToPageEvent extends PagerEvent {
  final double page;
  final double progress;
  const NavigateToPageEvent({required this.page, required this.progress});
  @override
  List<Object> get props => [page, progress];
}
