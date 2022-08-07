import 'package:dartz/dartz.dart';
import 'package:turistando/app/core/errors/failure.dart';
import 'package:turistando/app/core/services/rest_client/rest_client_service.dart';

import '../models/create_tour_payload_model.dart';

abstract class CreateTourRepository {
  Future<Either<ServerFailure, void>> createTour(CreateTourPayloadModel payload);
}

class CreateTourRepositoryImpl implements CreateTourRepository {
  // ignore: unused_field
  final RestClientService _restClient;

  CreateTourRepositoryImpl(this._restClient);

  @override
  Future<Either<ServerFailure, void>> createTour(CreateTourPayloadModel payload) async {
    await Future.delayed(const Duration(seconds: 1));
    // ignore: void_checks
    return const Right({});
  }
}
