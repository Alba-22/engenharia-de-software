import 'package:flutter_triple/flutter_triple.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/utils/constants.dart';

import 'models/login_payload_model.dart';
import 'models/login_response_model.dart';
import 'repositories/login_repository.dart';

class LoginStore extends StreamStore<String, LoginState> {
  final LoginRepository _repository;
  final LocalStorageService _localStorage;

  LoginStore(this._repository, this._localStorage) : super(LoginInitialState());

  void login(String email, String password) async {
    update(LoginLoadingState());
    final payload = LoginPayloadModel(email: email, password: password);
    final result = await _repository.login(payload);
    result.fold(
      (l) => update(LoginErrorState(l.message)),
      (r) async {
        await _localStorage.write(StorageKeys.accessToken, r.accessToken);
        update(LoginSuccessState(r));
      },
    );
  }
}

abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginResponseModel response;

  LoginSuccessState(this.response);
}

class LoginErrorState extends LoginState {
  final String message;
  LoginErrorState(this.message);
}
