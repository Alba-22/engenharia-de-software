import 'package:flutter_triple/flutter_triple.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/modules/register/models/register_payload_model.dart';
import 'package:turistando/app/modules/register/models/register_response_model.dart';
import 'package:turistando/app/modules/register/repositories/register_repository.dart';

class RegisterStore extends StreamStore<String, RegisterState> {
  final RegisterRepository _repository;
  final LocalStorageService _localStorage;

  RegisterStore(this._repository, this._localStorage) : super(RegisterInitialState());

  void register(String name, String email, String phone, String password) async {
    update(RegisterLoadingState());
    final payload = RegisterPayloadModel(
      name: name,
      email: email,
      phone: phone,
      password: password,
    );
    final result = await _repository.register(payload);
    result.fold(
      (l) => update(RegisterErrorState(l.message)),
      (r) async {
        await _localStorage.write(StorageKeys.accessToken, r.accessToken);
        update(RegisterSuccessState(r));
      },
    );
  }
}

abstract class RegisterState {}

class RegisterInitialState extends RegisterState {}

class RegisterLoadingState extends RegisterState {}

class RegisterSuccessState extends RegisterState {
  final RegisterResponseModel response;

  RegisterSuccessState(this.response);
}

class RegisterErrorState extends RegisterState {
  final String message;
  RegisterErrorState(this.message);
}
