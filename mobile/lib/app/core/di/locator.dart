import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/services/local_storage/secure_storage_service.dart';
import 'package:turistando/app/core/services/location_store.dart';
import 'package:turistando/app/modules/login/login_store.dart';
import 'package:turistando/app/modules/login/repositories/login_repository.dart';
import 'package:turistando/app/modules/register/register_store.dart';
import 'package:turistando/app/modules/register/repositories/register_repository.dart';
import 'package:turistando/app/modules/splash/splash_store.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => const FlutterSecureStorage());
  locator.registerFactory<LocalStorageService>(() => SecureStorage(locator.get()));
  locator.registerFactory(() => SplashStore(locator.get()));
  locator.registerFactory<LoginRepository>(() => LoginRepositoryImpl());
  locator.registerFactory(() => LoginStore(locator.get(), locator.get()));
  locator.registerFactory<RegisterRepository>(() => RegisterRepositoryImpl());
  locator.registerFactory(() => RegisterStore(locator.get(), locator.get()));

  locator.registerLazySingleton(() => LocationStore());
}
