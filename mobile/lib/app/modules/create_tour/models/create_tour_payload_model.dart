import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:turistando/app/core/models/place_model.dart';

class CreateTourPayloadModel {
  final String tourName;
  final List<PlaceModel> places;

  CreateTourPayloadModel({
    required this.tourName,
    required this.places,
  });

  CreateTourPayloadModel copyWith({
    String? tourName,
    List<PlaceModel>? places,
  }) {
    return CreateTourPayloadModel(
      tourName: tourName ?? this.tourName,
      places: places ?? this.places,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': tourName,
      'locations': places.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'CreateTourPayloadModel(tourName: $tourName, places: $places)';

  @override
  bool operator ==(covariant CreateTourPayloadModel other) {
    if (identical(this, other)) return true;

    return other.tourName == tourName && listEquals(other.places, places);
  }

  @override
  int get hashCode => tourName.hashCode ^ places.hashCode;
}
