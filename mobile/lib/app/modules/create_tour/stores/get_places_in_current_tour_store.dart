import 'dart:convert';

import 'package:flutter/cupertino.dart';

import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/services/logger/logger_service.dart';
import 'package:turistando/app/core/utils/constants.dart';

class GetPlacesInCurrentTourStore extends ValueNotifier<GetPlacesInCurrentTourState> {
  final LocalStorageService _localStorage;
  final LoggerService _logger;

  GetPlacesInCurrentTourStore(this._localStorage, this._logger)
      : super(GetPlacesInCurrentTourInitialState());

  Future<void> getPlacesInCurrentTour() async {
    value = GetPlacesInCurrentTourLoadingState();
    try {
      final placesStr = await _localStorage.read(StorageKeys.tourBeingCreated);

      if (placesStr == null || placesStr.isEmpty) {
        value = GetPlacesInCurrentTourEmptyState();
        return;
      }

      final List<PlaceModel> places = jsonDecode(placesStr).map<PlaceModel>((e) {
        return PlaceModel.fromJson(e);
      }).toList();

      if (places.isEmpty) {
        value = GetPlacesInCurrentTourEmptyState();
      } else {
        value = GetPlacesInCurrentTourSuccessState(places: places);
      }
    } catch (exception, stackTrace) {
      _logger.recordError(exception, stackTrace);
      value = GetPlacesInCurrentTourErrorState("Ocorreu um erro ao obter a lista de locais");
    }
  }
}

abstract class GetPlacesInCurrentTourState {}

class GetPlacesInCurrentTourInitialState extends GetPlacesInCurrentTourState {}

class GetPlacesInCurrentTourLoadingState extends GetPlacesInCurrentTourState {}

class GetPlacesInCurrentTourEmptyState extends GetPlacesInCurrentTourState {}

class GetPlacesInCurrentTourSuccessState extends GetPlacesInCurrentTourState {
  List<PlaceModel> places;
  GetPlacesInCurrentTourSuccessState({
    required this.places,
  });
}

class GetPlacesInCurrentTourErrorState extends GetPlacesInCurrentTourState {
  final String message;
  GetPlacesInCurrentTourErrorState(this.message);
}
