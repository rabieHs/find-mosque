import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_mosques/Features/home/presentation/controllers/bloc/home_bloc.dart';
import 'package:find_mosques/Features/landing/presentation/controllers/bloc/pager_bloc.dart';
import 'package:find_mosques/Features/mosques/data/datasources/remote/remote_datasource.dart';
import 'package:find_mosques/Features/mosques/data/repository/places_repository_impl.dart';
import 'package:find_mosques/Features/mosques/domain/repository/places_repository.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/add_mosque_info_usecase.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_all_mousques_usecase.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_mosque_info_usecase.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_place_location_by_id_usecase.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_place_suggestion_usecase.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/maps_bloc/maps_bloc.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/mosque_bloc/mosque_bloc.dart';
import 'package:find_mosques/Features/prayer/data/datasources/remote_datasource.dart';
import 'package:find_mosques/Features/prayer/data/repository/prayer_repository_impl.dart';
import 'package:find_mosques/Features/prayer/domain/repository/preyer_repository.dart';
import 'package:find_mosques/Features/prayer/domain/usecases/get_prayer_times_usecase.dart';
import 'package:find_mosques/Features/prayer/presentation/controllers/bloc/prayer_bloc.dart';
import 'package:find_mosques/Features/splash/presentation/controllers/bloc/luanch_bloc.dart';
import 'package:find_mosques/core/methods/error_handler.dart';
import 'package:find_mosques/core/methods/maps_methods.dart';
import 'package:find_mosques/core/methods/prayer_methods.dart';
import 'package:find_mosques/core/networks/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

class DependencyInjection {
  static Future<void> init() async {
    final Completer<GoogleMapController> completer =
        Completer<GoogleMapController>();
    final InternetConnectionChecker checker = InternetConnectionChecker();
    final NetworkInfo info = NetworkInfoImpl(connectionChecker: checker);
    final Client client = Client();
    final firestore = FirebaseFirestore.instance;
    final MapsMethos mapsMethos = MapsMethos();
    final PrayerMethods prayerMethods = PrayerMethods();

    sl.registerLazySingleton<NetworkInfo>(() => info);
    sl.registerLazySingleton<Client>(() => client);
    sl.registerLazySingleton<MapsMethos>(() => mapsMethos);
    sl.registerLazySingleton<ErrorHandler>(() => ErrorHandler());

    sl.registerLazySingleton<MosquesRemoteDatasource>(() =>
        MosquesRemoteDatasourceImpl(
            client: client, firebaseFireStore: FirebaseFirestore.instance));
    sl.registerLazySingleton<PrayerRemoteDataSource>(
        () => PrayerRemoteDataSourceImpl(client: client));

    sl.registerLazySingleton<PlacesRepository>(
        () => PlacesRepositoryImpl(networkInfo: sl(), remoteDatasource: sl()));
    sl.registerLazySingleton<PrayerRepository>(
        () => PrayerRepositoryImpl(remoteDatasource: sl(), networkInfo: sl()));

    sl.registerLazySingleton<GetAllMusquesUsecase>(
        () => GetAllMusquesUsecase(repository: sl()));
    sl.registerLazySingleton<GetMosqueInfoUsecase>(
        () => GetMosqueInfoUsecase(repository: sl()));
    sl.registerLazySingleton<AddMosqueInfoUsecase>(
        () => AddMosqueInfoUsecase(repository: sl()));
    sl.registerLazySingleton<GetPlaceSuggestionUsecase>(
        () => GetPlaceSuggestionUsecase(repository: sl()));
    sl.registerLazySingleton<GetPlaceLocationByIdUsecase>(
        () => GetPlaceLocationByIdUsecase(repository: sl()));
    sl.registerLazySingleton<GetPrayerUsecase>(
        () => GetPrayerUsecase(repository: sl()));

    sl.registerFactory(() => MapsBloc(sl(), completer, sl(), sl(), sl(), sl()));
    sl.registerFactory(() => MosqueBloc(sl(), sl(), sl()));
    sl.registerFactory(() => HomeBloc());
    sl.registerFactory(() => PrayerBloc(sl(), sl(), prayerMethods));

    sl.registerFactory(() => LuanchBloc());
    sl.registerFactory(() => PagerBloc());
  }
}
