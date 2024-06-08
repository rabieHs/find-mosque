// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

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
    final response = await client.get(Uri.parse("url"));
    if (response.statusCode == 200) {
      List<Map<String, dynamic>> data = jsonDecode(response.body);
      return data.map((e) => LocationModel.fromMap(e)).toList();
    } else {
      throw ServerException();
    }
  }
}
