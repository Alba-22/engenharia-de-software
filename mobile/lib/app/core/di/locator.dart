import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:turistando/app/core/repositories/places_repository.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/services/local_storage/secure_storage_service.dart';
import 'package:turistando/app/core/services/logger/custom_logger.dart';
import 'package:turistando/app/core/services/logger/logger_service.dart';
import 'package:turistando/app/core/store/location_store.dart';
import 'package:turistando/app/core/store/places_store.dart';
import 'package:turistando/app/modules/login/login_store.dart';
import 'package:turistando/app/modules/login/repositories/login_repository.dart';
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
}
