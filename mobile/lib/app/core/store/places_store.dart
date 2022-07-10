// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_triple/flutter_triple.dart';

import 'package:turistando/app/core/models/place_model.dart';
import 'package:turistando/app/core/repositories/places_repository.dart';
import 'package:turistando/app/core/services/logger/logger_service.dart';

class PlacesStore extends StreamStore<String, List<PlaceModel>> {
  final PlacesRepository _repository;
  final LoggerService _loggerService;

  PlacesStore(this._repository, this._loggerService) : super([]);

  Future<void> getAllPlacesByLatLng(double latitude, double longitude) async {
    setLoading(true);
    final result = await _repository.getPlaceByLatLng(latitude, longitude);
    result.fold(
      (l) {
        _loggerService.recordError(l.message, StackTrace.current);
        setError(l.message);
      },
      (r) => update(r),
    );
  }
}
