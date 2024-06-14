import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_all_mousques_usecase.dart';
import 'package:find_mosques/core/common/get_mosques_parameters.dart';
import 'package:find_mosques/core/constants/colors/colors.dart';
import 'package:find_mosques/core/methods/error_handler.dart';
import 'package:find_mosques/core/methods/maps_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final GetAllMusquesUsecase getAllMusquesUsecase;
  final MapsMethos mapsMethos;

  String _style = "";
  String get style => _style;
  Set<Polyline> _polylineCoordinates = {};
  Set<Polyline> get polylineCoordinates => _polylineCoordinates;

  Completer<GoogleMapController> _mapCompleterController;
  Completer<GoogleMapController> get mapCompleterController =>
      _mapCompleterController;

  GoogleMapController? _mapController;
  GoogleMapController get mapController => _mapController!;

  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  CameraPosition _currentPosition = const CameraPosition(
    target: LatLng(0, 0),
    zoom: 15,
  );
  CameraPosition get currentPosition => _currentPosition;

  MapsBloc(
      this.getAllMusquesUsecase, this._mapCompleterController, this.mapsMethos)
      : super(MapsInitial()) {
    on<InitializeMapsEvent>((event, emit) async {
      _currentPosition = await mapsMethos.getCurrentUserCameraPosition();
      _style = await MapsMethos().getJsonStyle("assets/styles/maps.json");
      _mapController = event.controller;
      _mapCompleterController.complete(_mapController);
      _mapController!.setMapStyle(_style);
      _mapController!
          .moveCamera(CameraUpdate.newCameraPosition(_currentPosition));
    });

    on<GetAllMosquesEventOnCameraMove>((event, emit) async {
      final icon = await mapsMethos.getMarkerIcon();
      emit(MosquesLoadingState());
      final GetMosquesParameters parameters = GetMosquesParameters(
          latitude: event.cameraPosition.target.latitude,
          longitude: event.cameraPosition.target.longitude);
      final result = await getAllMusquesUsecase(parameters);
      result.fold(
        (failure) {
          emit(MosquesLocationErrorState(
              message: mapFailureToMessage(
                  failure, AppLocalizations.of(event.context)!)));
        },
        (mosques) async {
          _markers = mapsMethos.getMarkers(
            mosques,
            icon,
            (location) => add(ShowMosqueLocationEvent(location: location)),
          );
          emit(MosquesLoadedState(
            mosques: mosques,
          ));
        },
      );
    });

    on<ShowMosqueLocationEvent>((event, emit) async {
      emit(const LoadingMosqueInfoState());
      emit(ShowMosqueLocationState(event.location));
    });

    on<GetRouteInfoEvent>((event, emit) async {
      emit(LoadingGetRouteInfoState());
      final roadName = await mapsMethos.getRoadName(event.lat, event.long);
      final distance =
          await mapsMethos.calculateDistance(event.lat, event.long);
      double estimatedTime = mapsMethos.calculateEstimatedTime(distance);
      emit(SuccessGetRouteInfoState(
          street: roadName, distance: distance, estimatedTime: estimatedTime));
    });

    on<StartNavigationEvent>((event, emit) async {
      _currentPosition = await mapsMethos.getCurrentUserCameraPosition();

      final pints = await mapsMethos.showRouteBetweenUserAndMosque(
          LatLng(
            _currentPosition.target.latitude,
            _currentPosition.target.longitude,
          ),
          LatLng(event.lat, event.long));
      _polylineCoordinates = {
        Polyline(
          polylineId: const PolylineId("route"),
          color: secondaryColor,
          width: 5,
          points: pints,
        ),
      };
      emit(SuccessNavigateState());
      _mapController!
          .animateCamera(CameraUpdate.newCameraPosition(_currentPosition));
    });
    on<CancelNavigationEvent>((event, emit) async {
      _polylineCoordinates = {};
      emit(CancelNavigateState());
    });
  }
}
