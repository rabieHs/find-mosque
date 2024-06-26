// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:find_mosques/Features/mosques/data/models/mosque_model.dart';
import 'package:find_mosques/Features/mosques/data/models/suggestion_model.dart';
import 'package:find_mosques/Features/mosques/domain/entities/location.dart';
import 'package:find_mosques/core/constants/strings/apis.dart';
import 'package:find_mosques/core/constants/strings/database.dart';
import 'package:find_mosques/core/constants/strings/keys.dart';
import 'package:find_mosques/core/error/exception.dart';
import 'package:http/http.dart';

import 'package:find_mosques/Features/mosques/data/models/location_model.dart';

abstract class MosquesRemoteDatasource {
  Future<List<LocationModel>> getAllMosques(double lat, double long);
  Future<MosqueModel> getMosqueInfo(LocationModel location);
  Future<Unit> addMosqueInfo(MosqueModel mosque);
  Future<List<SuggestionModel>> gePlacestSuggestions(
      String query, String country);
  Future<LocationModel> getPlaceLocationById(String id);
}

class MosquesRemoteDatasourceImpl implements MosquesRemoteDatasource {
  final FirebaseFirestore firebaseFireStore;
  final Client client;
  MosquesRemoteDatasourceImpl(
      {required this.client, required this.firebaseFireStore});

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

  @override
  Future<Unit> addMosqueInfo(MosqueModel mosque) async {
    try {
      await firebaseFireStore
          .collection(MOSQUES_COLLECTION)
          .doc(mosque.location.id)
          .set(mosque.toMap());
      return Future(() => unit);
    } on FirebaseException catch (_) {
      throw ServerException();
    }
  }

  @override
  Future<MosqueModel> getMosqueInfo(LocationModel location) async {
    final mosqueRef =
        firebaseFireStore.collection(MOSQUES_COLLECTION).doc(location.id);
    final response = await mosqueRef.get();

    if (response.exists && response.data() != null) {
      return MosqueModel.fromMap(response.data()!);
    } else if (!response.exists) {
      throw EmptyException();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SuggestionModel>> gePlacestSuggestions(
      String query, String country) async {
    print(country);
    final response = await client.get(Uri.parse(
        "$BASE_PLACES_SUGGESTIONS_URL?input=$query&components=country:$country&key=$MAPS_API_KEY"));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      List<dynamic> results = data['predictions'];
      if (results.isEmpty) {
        throw EmptyException();
      } else {
        return results.map((e) => SuggestionModel.fromJson(e)).toList();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<LocationModel> getPlaceLocationById(String id) async {
    final response = await client.get(
        Uri.parse("$BASE_PLACE_DETAILS_URL?place_id=$id&key=$MAPS_API_KEY"));
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      return LocationModel.fromMap(data['result']);
    } else {
      throw ServerException();
    }
  }
}
