import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:turistando/app/core/repositories/places_repository.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/services/local_storage/secure_storage_service.dart';
import 'package:turistando/app/core/services/logger/custom_logger.dart';
import 'package:turistando/app/core/services/logger/logger_service.dart';
import 'package:turistando/app/core/services/rest_client/dio_rest_client.dart';
import 'package:turistando/app/core/services/rest_client/rest_client_service.dart';
import 'package:turistando/app/core/store/location_store.dart';
import 'package:turistando/app/core/store/places_store.dart';
import 'package:turistando/app/environment.dart';
import 'package:turistando/app/modules/create_tour/repositories/create_tour_repository.dart';
import 'package:turistando/app/modules/create_tour/stores/create_tour_store.dart';
import 'package:turistando/app/modules/create_tour/stores/delete_place_from_current_tour_store.dart';
import 'package:turistando/app/modules/create_tour/stores/get_places_in_current_tour_store.dart';
import 'package:turistando/app/modules/list/repositories/list_repository.dart';
import 'package:turistando/app/modules/list/stores/get_highlighted_tours_store.dart';
import 'package:turistando/app/modules/login/login_store.dart';
import 'package:turistando/app/modules/login/repositories/login_repository.dart';
import 'package:turistando/app/modules/place/add_place_to_tour_store.dart';
import 'package:turistando/app/modules/place/favorite_place_store.dart';
import 'package:turistando/app/modules/register/register_store.dart';
import 'package:turistando/app/modules/register/repositories/register_repository.dart';
import 'package:turistando/app/modules/splash/splash_store.dart';

final locator = GetIt.instance;

void setupLocator() {
  final GetIt i = locator;

  // GENERAL
  locator.registerFactory(() => const FlutterSecureStorage());
  locator.registerFactory<LocalStorageService>(() => SecureStorage(i.get()));
  locator.registerFactory<LoggerService>(() => CustomLogger());
  locator.registerFactory<RestClientService>(() => DioRestClient(Environment.baseURL, Dio(), []));

  // SPLASH
  locator.registerFactory(() => SplashStore(i.get()));

  // LOGIN
  locator.registerFactory<LoginRepository>(() => LoginRepositoryImpl());
  locator.registerFactory(() => LoginStore(i.get(), i.get()));

  // REGISTER
  locator.registerFactory<RegisterRepository>(() => RegisterRepositoryImpl());
  locator.registerFactory(() => RegisterStore(i.get(), i.get()));

  // LOCATION
  locator.registerLazySingleton(() => LocationStore(i.get()));

  // PLACES
  locator.registerFactory<PlacesRepository>(() => PlacesRepositoryImpl());
  locator.registerLazySingleton(() => PlacesStore(i.get(), i.get()));

  // FAVORITES
  locator.registerLazySingleton(() => FavoritePlaceStore(i.get()));

  // TOUR
  locator.registerLazySingleton(() => AddPlaceToTourStore(i.get(), i.get()));
  locator.registerLazySingleton(() => GetPlacesInCurrentTourStore(i.get(), i.get()));
  locator.registerLazySingleton(() => DeletePlaceFromCurrentTourStore(i.get(), i.get()));
  locator.registerFactory<CreateTourRepository>(() => CreateTourRepositoryImpl(i.get()));
  locator.registerLazySingleton(() => CreateTourStore(i.get(), i.get(), i.get()));

  // LIST
  locator.registerFactory<ListRepository>(() => ListRepositoryImpl(i.get()));
  locator.registerLazySingleton(() => GetHighlightedToursStore(i.get(), i.get()));
}
