import 'dart:async';

import 'package:find_mosques/Features/mosques/data/datasources/remote/remote_datasource.dart';
import 'package:find_mosques/Features/mosques/data/repository/mosques_repository_impl.dart';
import 'package:find_mosques/Features/mosques/domain/repository/mosques_repository.dart';
import 'package:find_mosques/Features/mosques/domain/usecases/get_all_mousques_usecase.dart';
import 'package:find_mosques/Features/mosques/presentation/controllers/bloc/maps_bloc.dart';
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

    sl.registerLazySingleton<NetworkInfo>(() => info);
    sl.registerLazySingleton<Client>(() => client);

    sl.registerLazySingleton<MosquesRemoteDatasource>(
        () => MosquesRemoteDatasourceImpl(client: client));

    sl.registerLazySingleton<MosquesRepository>(
        () => MosquesRepositoryImpl(networkInfo: sl(), remoteDatasource: sl()));

    sl.registerLazySingleton<GetAllMusquesUsecase>(
        () => GetAllMusquesUsecase(repository: sl()));

    sl.registerFactory(() => MapsBloc(sl(), completer));
  }
}
