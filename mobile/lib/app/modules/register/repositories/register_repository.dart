import 'package:dartz/dartz.dart';
import 'package:turistando/app/core/errors/failure.dart';

import '../models/register_payload_model.dart';
import '../models/register_response_model.dart';

abstract class RegisterRepository {
  Future<Either<ServerFailure, RegisterResponseModel>> register(RegisterPayloadModel payload);
}

class RegisterRepositoryImpl implements RegisterRepository {
  @override
  Future<Either<ServerFailure, RegisterResponseModel>> register(
    RegisterPayloadModel payload,
  ) async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(RegisterResponseModel(accessToken: "abc"));
  }
}
