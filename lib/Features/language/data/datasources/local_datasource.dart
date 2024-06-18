// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:find_mosques/core/constants/strings/database.dart';
import 'package:find_mosques/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalLanguageSatasource {
  Future<Unit> changeLanguage(String languageCode);
  Future<String> getLanguage();
}

class LocalLanguageDatasourceImpl implements LocalLanguageSatasource {
  final SharedPreferences sharedPreferences;
  LocalLanguageDatasourceImpl({
    required this.sharedPreferences,
  });
  @override
  Future<Unit> changeLanguage(String languageCode) async {
    final response =
        await sharedPreferences.setString(LANGUAGE_KEY, languageCode);
    if (response) {
      print("response is $response");
      return unit;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<String> getLanguage() {
    final language = sharedPreferences.getString(LANGUAGE_KEY);
    if (language != null) {
      return Future.value(language);
    } else {
      throw ServerException();
    }
  }
}
