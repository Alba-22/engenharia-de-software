import 'package:dartz/dartz.dart';
import 'package:turistando/app/core/errors/failure.dart';
import 'package:turistando/app/modules/login/models/login_payload_model.dart';
import 'package:turistando/app/modules/login/models/login_response_model.dart';

abstract class LoginRepository {
  Future<Either<ServerFailure, LoginResponseModel>> login(LoginPayloadModel payload);
}

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<ServerFailure, LoginResponseModel>> login(LoginPayloadModel payload) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(LoginResponseModel(accessToken: "abc"));
  }
}
