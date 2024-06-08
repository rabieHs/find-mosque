import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:find_mosques/core/methods/maps_methods.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'maps_event.dart';
part 'maps_state.dart';

class MapsBloc extends Bloc<MapsEvent, MapsState> {
  Completer<GoogleMapController> _mapCompleterController =
      Completer<GoogleMapController>();
  Completer<GoogleMapController> get mapCompleterController =>
      _mapCompleterController;

  GoogleMapController? _mapController;
  GoogleMapController get mapController => _mapController!;

  MapsBloc() : super(MapsInitial()) {
    on<InitializeMapsEvent>((event, emit) async {
      String style = await MapsMethos().getJsonStyle("assets/styles/maps.json");
      _mapController = event.controller;

      _mapCompleterController.complete(_mapController);
      print("success initialized");

      _mapController!.setMapStyle(style);
      print("success change style");

      _mapController!.animateCamera(CameraUpdate.newCameraPosition(
          await MapsMethos().getCurrentUserLocation()));
      print("success get position");
    });
  }
}
