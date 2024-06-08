import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsMethos {
  Future<CameraPosition> getCurrentUserLocation() async {
    if (await Geolocator.checkPermission() == LocationPermission.denied) {
      await Geolocator.requestPermission();
    }
    Position userPositon = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);

    LatLng userPositionLatLang =
        LatLng(userPositon.latitude, userPositon.longitude);
    return CameraPosition(target: userPositionLatLang, zoom: 15);
  }

  Future<String> getJsonStyle(String stylePath) async {
    ByteData byteData = await rootBundle.load(stylePath);

    var list = byteData.buffer
        .asUint8List(byteData.offsetInBytes, byteData.lengthInBytes);
    return utf8.decode(list);
  }
}
