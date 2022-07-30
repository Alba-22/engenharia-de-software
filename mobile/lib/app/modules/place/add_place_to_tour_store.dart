import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/services/logger/logger_service.dart';
import 'package:turistando/app/core/utils/constants.dart';

class AddPlaceToTourStore extends ValueNotifier<AddPlaceToTourState> {
  final LocalStorageService _localStorage;
  final LoggerService _logger;

  AddPlaceToTourStore(this._localStorage, this._logger) : super(AddPlaceToTourInitialState());

  Future<void> addToTour(PlaceModel place) async {
    value = AddPlaceToTourLoadingState();
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final placesInTour = await _getPlacesInTour() ?? [];

      if (placesInTour.contains(place)) {
        value = AddPlaceToTourErrorState("Esse local já está no tour atual");
        return;
      }

      placesInTour.add(place);

      final List<String> placesListWithNewItem = placesInTour.map((e) {
        return e.toJson();
      }).toList();

      final encodedPlaces = jsonEncode(placesListWithNewItem);

      await _localStorage.write(StorageKeys.tourBeingCreated, encodedPlaces);
      value = AddPlaceToTourSuccessState();
    } catch (exception, stackTrace) {
      value = AddPlaceToTourErrorState("Ocorreu um erro ao adicionar ao tour!");
      _logger.recordError(exception, stackTrace);
    }
  }

  Future<List<PlaceModel>?> _getPlacesInTour() async {
    final placesInTourStr = await _localStorage.read(StorageKeys.tourBeingCreated);
    if (placesInTourStr == null || placesInTourStr.isEmpty) {
      return null;
    }
    final List<PlaceModel> placesInTour = jsonDecode(placesInTourStr).map<PlaceModel>((e) {
      return PlaceModel.fromJson(e);
    }).toList();

    return placesInTour;
  }
}

abstract class AddPlaceToTourState {}

class AddPlaceToTourInitialState extends AddPlaceToTourState {}

class AddPlaceToTourLoadingState extends AddPlaceToTourState {}

class AddPlaceToTourSuccessState extends AddPlaceToTourState {}

class AddPlaceToTourErrorState extends AddPlaceToTourState {
  final String message;
  AddPlaceToTourErrorState(this.message);
}
