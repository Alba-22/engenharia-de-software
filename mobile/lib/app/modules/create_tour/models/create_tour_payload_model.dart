// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:turistando/app/core/models/place_model.dart';

class CreateTourPayloadModel extends Equatable {
  final String tourName;
  final List<PlaceModel> places;

  const CreateTourPayloadModel({
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
  List<Object> get props => [tourName, places];
}
