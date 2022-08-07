import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:turistando/app/core/models/place_model.dart';

import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/services/logger/logger_service.dart';
import 'package:turistando/app/core/utils/constants.dart';

class DeletePlaceFromCurrentTourStore extends ValueNotifier<DeletePlaceFromCurrentTourState> {
  final LocalStorageService _localStorage;
  final LoggerService _logger;

  DeletePlaceFromCurrentTourStore(
    this._localStorage,
    this._logger,
  ) : super(DeletePlaceFromCurrentTourInitialState());

  Future<void> deletePlaceFromCurrentTour(PlaceModel place) async {
    value = DeletePlaceFromCurrentTourLoadingState();
    try {
      final placesStr = await _localStorage.read(StorageKeys.tourBeingCreated);

      if (placesStr == null || placesStr.isEmpty) {
        value = DeletePlaceFromCurrentTourErrorState("Ocorreu um erro ao remover o local do tour!");
        return;
      }

      final List<PlaceModel> placesInTour = jsonDecode(placesStr).map<PlaceModel>((e) {
        return PlaceModel.fromJson(e);
      }).toList();

      if (placesInTour.isEmpty) {
        value = DeletePlaceFromCurrentTourErrorState("Ocorreu um erro ao remover o local do tour!");
      } else {
        placesInTour.remove(place);

        final List<String> placesListWithNewItem = placesInTour.map((e) {
          return e.toJson();
        }).toList();

        final encodedPlaces = jsonEncode(placesListWithNewItem);

        await _localStorage.write(StorageKeys.tourBeingCreated, encodedPlaces);

        value = DeletePlaceFromCurrentTourSuccessState();
      }
    } catch (exception, stackTrace) {
      _logger.recordError(exception, stackTrace);
      value = DeletePlaceFromCurrentTourErrorState("Ocorreu um erro ao remover o local do tour!");
    }
  }
}

abstract class DeletePlaceFromCurrentTourState {}

class DeletePlaceFromCurrentTourInitialState extends DeletePlaceFromCurrentTourState {}

class DeletePlaceFromCurrentTourLoadingState extends DeletePlaceFromCurrentTourState {}

class DeletePlaceFromCurrentTourSuccessState extends DeletePlaceFromCurrentTourState {}

class DeletePlaceFromCurrentTourErrorState extends DeletePlaceFromCurrentTourState {
  final String message;
  DeletePlaceFromCurrentTourErrorState(this.message);
}
