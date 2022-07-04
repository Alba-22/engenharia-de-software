import 'package:flutter_triple/flutter_triple.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/utils/constants.dart';

class SplashStore extends StreamStore<String, SplashState> {
  final LocalStorageService _localStorage;

  SplashStore(this._localStorage) : super(SplashInitialState());

  void manageSplash() async {
    update(SplashLoadingState());
    await Future.delayed(const Duration(milliseconds: 750));
    final result = await _localStorage.read(StorageKeys.accessToken);
    if (result != null && result.isNotEmpty) {
      update(SplashEntryState());
    } else {
      update(SplashLoginState());
    }
  }
}

abstract class SplashState {}

class SplashInitialState extends SplashState {}

class SplashLoadingState extends SplashState {}

class SplashEntryState extends SplashState {}

class SplashLoginState extends SplashState {}
