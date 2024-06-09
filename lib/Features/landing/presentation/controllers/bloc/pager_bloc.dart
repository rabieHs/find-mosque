import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'pager_event.dart';
part 'pager_state.dart';

class PagerBloc extends Bloc<PagerEvent, PagerState> {
  PagerBloc() : super(PagerInitial()) {
    on<NavigateToPageEvent>((event, emit) {
      if (event.page == 3) {
        emit(NavigatePageState());
      } else {
        emit(ChangePageState(
            index: event.page.toInt() + 1, progress: event.progress + 25));
      }
    });
  }
}
