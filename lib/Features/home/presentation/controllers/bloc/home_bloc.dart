import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  bool _isDrowerOpen = false;
  int _page = 0;
  int get page => _page;

  bool get isDrowerOpen => _isDrowerOpen;

  HomeBloc() : super(HomeInitial()) {
    on<openDrawerEvent>((event, emit) {
      _isDrowerOpen = true;
      double xOffset = event.languageCode == "ar" ? -50 : 230;
      double yOffset = 150;
      double scaleFoctor = 0.6;
      emit(DrawerOpenedState(
        xOffset: xOffset,
        yOffset: yOffset,
        scaleFoctor: scaleFoctor,
        shoadowxOffset:
            event.languageCode == "ar" ? xOffset + 50 : xOffset - 50,
        shoadowyOffset: yOffset + 20,
        shoadowscaleFoctor: scaleFoctor - 0.05,
      ));
    });

    on<closeDrawerEvent>((event, emit) {
      _isDrowerOpen = false;
      double xOffset = 0;
      double yOffset = 0;
      double scaleFoctor = 1;

      emit(DrawerClosedstate(
        xOffset: xOffset,
        yOffset: yOffset,
        scaleFoctor: scaleFoctor,
      ));
    });

    on<ChangePageEvent>((event, emit) {
      switch (event.itemId) {
        case 1:
          _page = 1;
          break;
        case 2:
          _page = 2;
          break;
        default:
          _page = 0;
          break;
      }
      add(closeDrawerEvent());
    });
  }
}
