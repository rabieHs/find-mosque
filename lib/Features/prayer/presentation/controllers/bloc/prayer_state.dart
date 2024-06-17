part of 'prayer_bloc.dart';

sealed class PrayerState extends Equatable {
  const PrayerState();

  @override
  List<Object> get props => [];
}

final class PrayerInitial extends PrayerState {}

final class LoadingPrayerState extends PrayerState {}

final class ErrorPrayerState extends PrayerState {}

final class LoadedPrayerState extends PrayerState {
  final List<Prayer> prayers;

  const LoadedPrayerState({required this.prayers});
  @override
  List<Object> get props => [prayers];
}
