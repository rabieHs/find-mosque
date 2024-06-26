import 'dart:convert';

import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';
import 'package:find_mosques/core/constants/strings/keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Features/mosques/domain/entities/location.dart';

class MapsMethos {
  Future<CameraPosition> getCurrentUserCameraPosition() async {
    LatLng userPositionLatLang = await getCurrentUserPosition();

    return CameraPosition(target: userPositionLatLang, zoom: 15);
  }

  Future<String> getMapsCountry(GoogleMapController controller) async {
    final region = await controller.getVisibleRegion();

    final lat = (region.northeast.latitude + region.southwest.latitude) / 2;
    final long = (region.northeast.longitude + region.southwest.longitude) / 2;
    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(lat, long);
      return placemarks[0].isoCountryCode!;
    } catch (e) {
      throw Exception("Error in getting country code");
    }
  }

  Future<String> getUserAddress() async {
    LatLng userPosition = await getCurrentUserPosition();

    try {
      List<geocoding.Placemark> placemarks =
          await geocoding.placemarkFromCoordinates(
              userPosition.latitude, userPosition.longitude);
      return "${placemarks[0].subLocality} ${placemarks[0].locality} ${placemarks[0].isoCountryCode}";
    } catch (e) {
      throw Exception("Error in getting country code");
    }
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
        "assets/icons/mosque_pin_x64.png");
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
        geocoding.Placemark placemark = placemarks[0];
        return placemark.street ?? placemark.name ?? placemark.locality!;
      } else {
        return 'Unknown location';
      }
    } catch (e) {
      return 'Unknown location';
    }
  }

  Future<List<LatLng>> showRouteBetweenUserAndMosque(
      LatLng userPosition, LatLng mosquePosition) async {
    try {
      final PolylinePoints polylinePoints = PolylinePoints();
      final result = await polylinePoints.getRouteBetweenCoordinates(
        MAPS_API_KEY,
        PointLatLng(userPosition.latitude, userPosition.longitude),
        PointLatLng(mosquePosition.latitude, mosquePosition.longitude),
      );
      return result.points.map((e) => LatLng(e.latitude, e.longitude)).toList();
    } catch (e) {
      throw Exception("Error in getting polyline points");
    }
  }
}
