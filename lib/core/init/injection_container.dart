import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_location/core/_core_exports.dart';
import 'package:google_maps_location/feature/_feature_exports.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async {
  //! External

  //? Http Client
  serviceLocator.registerLazySingleton(() => Dio());

  //! Core

  //? Remote Data Source
  //* Repo
  serviceLocator.registerLazySingleton<BaseRequestRepository>(() => MainRequestImpl(
        serviceLocator(),
      ));

  serviceLocator.registerLazySingleton(() => MainBaseGet(serviceLocator()));
  serviceLocator.registerLazySingleton(() => MainBasePost(serviceLocator()));

  //!Future

  //?Maps
  serviceLocator.registerLazySingleton<MapRepo>(() => MapRepoImpl(serviceLocator()));
  serviceLocator.registerLazySingleton(() => FetchLocationDataUsecase(mapRepo: serviceLocator()));
  serviceLocator.registerLazySingleton<UserLocationProvider>(() => UserLocationProvider(serviceLocator()));
}
