import 'dart:convert';

import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Features/mosques/domain/entities/location.dart';

class MapsMethos {
  Future<CameraPosition> getCurrentUserCameraPosition() async {
    LatLng userPositionLatLang = await getCurrentUserPosition();

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
        const ImageConfiguration(size: Size(50, 50)),
        "assets/icons/marker_5.png");
  }

  Set<Marker> getMarkers(List<Location> mosques, BitmapDescriptor icon,
      void Function(Location)? onTap) {
    return mosques
        .map((e) => Marker(
            icon: icon,
            markerId: MarkerId(e.id),
            position: LatLng(e.latitude, e.longitude),
            infoWindow: InfoWindow(title: e.name, onTap: () {}),
            onTap: () => onTap!(e)))
        .toSet();
  }

  Future<double> calculateDistance(double lat, double long) async {
    LatLng currentPosition = await getCurrentUserPosition();
    double distance = Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      lat,
      long,
    );
    return double.parse((distance / 1000).toStringAsFixed(1));
  }

  double calculateEstimatedTime(double distance) {
    final estimatedTime = (distance / 5) * 60;
    return double.parse(estimatedTime.toStringAsFixed(2));
  }

  Future<String> getRoadName(double lat, double long) async {
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(lat, long);
      if (placemarks != null && placemarks.isNotEmpty) {
        print("success get placemark");
        geocoding.Placemark placemark = placemarks[0];
        return placemark.street ?? placemark.name ?? placemark.locality!;
      } else {
        return 'Unknown location';
      }
    } catch (e) {
      print(e);
      return 'Unknown location';
    }
  }
}
