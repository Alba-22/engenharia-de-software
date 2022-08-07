import 'package:flutter/cupertino.dart';

import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/services/logger/logger_service.dart';
import 'package:turistando/app/core/utils/constants.dart';
import 'package:turistando/app/modules/create_tour/models/create_tour_payload_model.dart';
import 'package:turistando/app/modules/create_tour/repositories/create_tour_repository.dart';

class CreateTourStore extends ValueNotifier<CreateTourState> {
  final CreateTourRepository _repository;
  final LocalStorageService _localStorage;
  final LoggerService _logger;

  CreateTourStore(
    this._repository,
    this._localStorage,
    this._logger,
  ) : super(CreateTourInitialState());

  Future<void> createTour(String name, List<PlaceModel> places) async {
    value = CreateTourLoadingState();
    try {
      final payload = CreateTourPayloadModel(tourName: name, places: places);
      final result = await _repository.createTour(payload);
      return result.fold(
        (l) => value = CreateTourErrorState("Ocorreu um erro ao criar o tour!"),
        (r) async {
          await _localStorage.write(StorageKeys.tourBeingCreated, null);
          value = CreateTourSuccessState();
        },
      );
    } catch (exception, stackTrace) {
      value = CreateTourErrorState("Ocorreu um erro ao criar o tour!");
      _logger.recordError(exception, stackTrace);
    }
  }
}

abstract class CreateTourState {}

class CreateTourInitialState extends CreateTourState {}

class CreateTourLoadingState extends CreateTourState {}

class CreateTourSuccessState extends CreateTourState {}

class CreateTourErrorState extends CreateTourState {
  final String message;
  CreateTourErrorState(this.message);
}
