import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/utils/constants.dart';

class FavoritePlaceStore extends ChangeNotifier {
  final LocalStorageService _localStorage;

  FavoritePlaceStore(this._localStorage);

  Future<void> savePlaceToFavorites(PlaceModel place) async {
    final places = await _getPlacesInLocalStorage() ?? [];

    places.add(place);

    await _writePlacesToLocalStorage(places);
  }

  Future<void> removePlaceFromFavorites(PlaceModel place) async {
    final places = await _getPlacesInLocalStorage();

    if (places == null) return;

    places.remove(place);

    await _writePlacesToLocalStorage(places);
  }

  Future<bool> getIfPlaceIsFavorited(PlaceModel place) async {
    final places = await _getPlacesInLocalStorage() ?? [];
    return places.contains(place);
  }

  Future<List<PlaceModel>?> _getPlacesInLocalStorage() async {
    final placesStr = await _localStorage.read(StorageKeys.favoritePlaces);
    if (placesStr == null || placesStr.isEmpty) {
      return null;
    }
    final List<PlaceModel> places = jsonDecode(placesStr).map<PlaceModel>((e) {
      return PlaceModel.fromJson(e);
    }).toList();

    return places;
  }

  Future<void> _writePlacesToLocalStorage(List<PlaceModel> places) async {
    final List<String> placesListWithNewItem = places.map((e) {
      return e.toJson();
    }).toList();

    final encodedPlaces = jsonEncode(placesListWithNewItem);

    await _localStorage.write(StorageKeys.favoritePlaces, encodedPlaces);
  }
}
