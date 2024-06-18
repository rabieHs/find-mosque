part of 'language_bloc.dart';

abstract class LanguageState extends Equatable {
  const LanguageState();

  @override
  List<Object> get props => [];
}

final class LanguageInitial extends LanguageState {}

class LanguageLoaded extends LanguageState {
  final String languageCode;
  const LanguageLoaded({required this.languageCode});
  @override
  // TODO: implement props
  List<Object> get props => [languageCode];
}

class LoadingLanguage extends LanguageState {}

class ErrorLanguageState extends LanguageState {
  final String message;
  const ErrorLanguageState({required this.message});
  @override
  // TODO: implement props
  List<Object> get props => [message];
}
