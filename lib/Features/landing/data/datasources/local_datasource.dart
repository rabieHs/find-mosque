// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:find_mosques/core/constants/strings/database.dart';
import 'package:find_mosques/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalLandingDatasource {
  Future<Unit> saveLanding();
  Future<String> getLanding();
}

class LocalLandingDatasourceImpl implements LocalLandingDatasource {
  final SharedPreferences sharedPreferences;
  LocalLandingDatasourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<Unit> saveLanding() async {
    final response = await sharedPreferences.setString(LANDING_KEY, "landing");
    if (response) {
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> getLanding() {
    final language = sharedPreferences.getString(LANDING_KEY);
    if (language != null) {
      return Future.value(language);
    } else {
      throw ServerException();
    }
  }
}
