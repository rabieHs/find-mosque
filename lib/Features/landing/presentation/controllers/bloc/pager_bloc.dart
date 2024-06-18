import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_mosques/Features/landing/domain/usecases/get_landing_usecase.dart';
import 'package:find_mosques/Features/landing/domain/usecases/save_landing_usecase.dart';
import 'package:find_mosques/core/parameters/no_parameters.dart';

part 'pager_event.dart';
part 'pager_state.dart';

class PagerBloc extends Bloc<PagerEvent, PagerState> {
  String _landingKey = '';
  String get landingKey => _landingKey;
  final SaveLandingUsecase saveLandingUsecase;
  final GetLandingUsecase getLandingUsecase;
  PagerBloc(this.saveLandingUsecase, this.getLandingUsecase)
      : super(PagerInitial()) {
    on<NavigateToPageEvent>((event, emit) async {
      if (event.page == 3) {
        await saveLandingUsecase(NoParameters()).whenComplete(() {
          emit(NavigatePageState());
        });
      } else {
        emit(ChangePageState(
            index: event.page.toInt() + 1, progress: event.progress + 25));
      }
    });

    on<GetLandingEvent>((event, emit) async {
      final response = await getLandingUsecase(NoParameters());
      response.fold((l) {}, (r) {
        print("landing key: $r");
        _landingKey = r;
      });
    });
  }
}
