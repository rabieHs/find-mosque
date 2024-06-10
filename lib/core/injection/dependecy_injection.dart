import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:find_mosques/Features/landing/presentation/controllers/bloc/pager_bloc.dart';
import 'package:find_mosques/Features/mosques/data/datasources/remote/remote_datasource.dart';
import 'package:find_mosques/Features/mosques/data/repository/mosques_repository_impl.dart';
import 'package:find_mosques/Features/mosques/domain/repository/mosques_repository.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_all_mousques_usecase.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/bloc/maps_bloc.dart';
import 'package:find_mosques/Features/splash/presentation/controllers/bloc/luanch_bloc.dart';
import 'package:find_mosques/core/methods/maps_methods.dart';
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
    final firestore = await FirebaseFirestore.instance;

    sl.registerLazySingleton<NetworkInfo>(() => info);
    sl.registerLazySingleton<Client>(() => client);
    sl.registerLazySingleton<MapsMethos>(() => MapsMethos());

    sl.registerLazySingleton<MosquesRemoteDatasource>(() =>
        MosquesRemoteDatasourceImpl(
            client: client, firebaseFireStore: firestore));

    sl.registerLazySingleton<MosquesRepository>(
        () => MosquesRepositoryImpl(networkInfo: sl(), remoteDatasource: sl()));

    sl.registerLazySingleton<GetAllMusquesUsecase>(
        () => GetAllMusquesUsecase(repository: sl()));

    sl.registerFactory(() => MapsBloc(sl(), completer, sl()));
    sl.registerFactory(() => LuanchBloc());
    sl.registerFactory(() => PagerBloc());
  }
}