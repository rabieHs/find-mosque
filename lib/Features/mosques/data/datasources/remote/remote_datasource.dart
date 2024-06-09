// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:find_mosques/core/constants/strings/apis.dart';
import 'package:find_mosques/core/constants/strings/keys.dart';
import 'package:find_mosques/core/error/exception.dart';
import 'package:http/http.dart';

import 'package:find_mosques/Features/mosques/data/models/location_model.dart';

abstract class MosquesRemoteDatasource {
  Future<List<LocationModel>> getAllMosques(double lat, double long);
}

class MosquesRemoteDatasourceImpl implements MosquesRemoteDatasource {
  final Client client;
  MosquesRemoteDatasourceImpl({
    required this.client,
  });

  @override
  Future<List<LocationModel>> getAllMosques(double lat, double long) async {
    final response = await client.get(Uri.parse(
        "$BASE_MOSQUES_URL?location=$lat,$long&radius=2000&type=mosque&key=$MAPS_API_KEY"));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> results = data['results'];
      return results.map((e) => LocationModel.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
