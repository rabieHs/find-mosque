import 'dart:convert';

import 'package:find_mosques/Features/mosques/presentation/controllers/bloc/maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Features/mosques/domain/entities/location.dart';

class MapsMethos {
  Future<CameraPosition> getCurrentUserCameraPosition() async {
    if (await Geolocator.checkPermission() == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    Position userPositon = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    LatLng userPositionLatLang =
        LatLng(userPositon.latitude, userPositon.longitude);
    return CameraPosition(target: userPositionLatLang, zoom: 15);
  }

  Future<LatLng> getCurrentUserPosition() async {
    if (await Geolocator.checkPermission() == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    Position userPositon = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);

    LatLng userPositionLatLang =
        LatLng(userPositon.latitude, userPositon.longitude);
    print("user position: ${userPositionLatLang.latitude}");
    return userPositionLatLang;
  }

  Future<String> getJsonStyle(String stylePath) async {
    ByteData byteData = await rootBundle.load(stylePath);

    var list = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }

  Future<BitmapDescriptor> getMarkerIcon() async {
    return await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)), "assets/icons/marker_3.png");
  }

  Set<Marker> getMarkers(List<Location> mosques, BitmapDescriptor icon,
      void Function(String, String)? onTap) {
    return mosques
        .map((e) => Marker(
            icon: icon,
            markerId: MarkerId(e.id),
            position: LatLng(e.latitude, e.longitude),
            infoWindow: InfoWindow(
                title: e.name,
                onTap: () {
                  print("marker id: ${e.id}");
                }),
            onTap: () => onTap!(e.id, e.name)))
        .toSet();
  }
}
