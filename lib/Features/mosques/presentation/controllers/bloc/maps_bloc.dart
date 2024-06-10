import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_all_mousques_usecase.dart';
import 'package:find_mosques/core/common/get_mosques_parameters.dart';
import 'package:find_mosques/core/error/failure.dart';
import 'package:find_mosques/core/methods/error_handler.dart';
import 'package:find_mosques/core/methods/maps_methods.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  final GetAllMusquesUsecase getAllMusquesUsecase;
  final MapsMethos mapsMethos;

  String _style = "";
  String get style => _style;

  Completer<GoogleMapController> _mapCompleterController;
  Completer<GoogleMapController> get mapCompleterController =>
      _mapCompleterController;

  GoogleMapController? _mapController;
  GoogleMapController get mapController => _mapController!;

  Set<Marker> _markers = {};
  Set<Marker> get markers => _markers;

  CameraPosition _currentPosition = CameraPosition(
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
        (failure) =>
            emit(MosquesErrorState(message: mapFailureToMessage(failure))),
        (mosques) async {
          _markers = mapsMethos.getMarkers(
            mosques,
            icon,
            (id, name) =>
                add(GetMosqueInfoEvent(markerId: id, mosqueName: name)),
          );
          emit(MosquesLoadedState(
            mosques: mosques,
          ));
        },
      );
    });

    on<GetMosqueInfoEvent>((event, emit) async {
      emit(const LoadingMosqueInfoState());
      emit(ShowMosqueInfoState(event.mosqueName));
    });
  }
}
