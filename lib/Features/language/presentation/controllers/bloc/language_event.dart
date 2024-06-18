part of 'language_bloc.dart';

abstract class LanguageEvent extends Equatable {
  const LanguageEvent();

  @override
  List<Object> get props => [];
}

class ChangeLanguageEvent extends LanguageEvent {
  final String languageCode;
  const ChangeLanguageEvent({required this.languageCode});
}

class GetLanguageEvent extends LanguageEvent {}
