// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'prayer_bloc.dart';

abstract class PrayerEvent extends Equatable {
  const PrayerEvent();

  @override
  List<Object> get props => [];
}

class GetPrayerTimesEvent extends PrayerEvent {
  final BuildContext context;
  const GetPrayerTimesEvent({
    required this.context,
  });
  @override
  List<Object> get props => [context];
}

class GetNextPrayerEvent extends PrayerEvent {
  final BuildContext context;
  const GetNextPrayerEvent({
    required this.context,
  });
  @override
  List<Object> get props => [context];
}
