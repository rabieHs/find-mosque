import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'luanch_event.dart';
part 'luanch_state.dart';

class LuanchBloc extends Bloc<LuanchEvent, LuanchState> {
  LuanchBloc() : super(LuanchInitial()) {
    on<StartSplashEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 4))
          .whenComplete(() => emit(LuanchLoaded()));
    });
  }
}
