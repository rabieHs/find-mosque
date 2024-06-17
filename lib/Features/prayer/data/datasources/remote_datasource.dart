// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:find_mosques/core/constants/strings/apis.dart';
import 'package:find_mosques/core/error/exception.dart';
import 'package:http/http.dart';

import 'package:find_mosques/Features/prayer/data/models/prayer_model.dart';

abstract class PrayerRemoteDataSource {
  Future<PrayerModel> getPrayerTimes(String address, String date);
}

class PrayerRemoteDataSourceImpl implements PrayerRemoteDataSource {
  final Client client;
  PrayerRemoteDataSourceImpl({
    required this.client,
  });
  @override
  Future<PrayerModel> getPrayerTimes(String address, String date) async {
    final response = await client
        .get(Uri.parse("$BASE_PRAYER_TIME_URL/$date?address=$address"));
    if (response.statusCode == 200) {
      return PrayerModel.fromJson(response.body);
    } else {
      throw ServerException();
    }
  }
}
