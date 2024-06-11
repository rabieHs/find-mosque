// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:find_mosques/Features/mosques/data/models/mosque_model.dart';
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
    } on FirebaseException catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future<MosqueModel> getMosqueInfo(LocationModel location) async {
    try {
      final mosqueRef =
          firebaseFireStore.collection(MOSQUES_COLLECTION).doc(location.id);
      return await mosqueRef
          .get()
          .then((value) => MosqueModel.fromMap(value.data()!));
    } on FirebaseException catch (e) {
      print(e);
      throw ServerException();
    }
  }
}
