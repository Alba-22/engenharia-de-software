// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:turistando/app/core/models/place_model.dart';

class TourDetailsModel extends Equatable {
  final String title;
  final String description;
  final List<PlaceModel> places;

  const TourDetailsModel({
    required this.title,
    required this.description,
    required this.places,
  });

  TourDetailsModel copyWith({
    String? title,
    String? description,
    List<PlaceModel>? places,
  }) {
    return TourDetailsModel(
      title: title ?? this.title,
      description: description ?? this.description,
      places: places ?? this.places,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'description': description,
      'places': places.map((x) => x.toMap()).toList(),
    };
  }

  factory TourDetailsModel.fromMap(Map<String, dynamic> map) {
    return TourDetailsModel(
      title: map['title'] as String,
      description: map['description'] as String,
      places: List<PlaceModel>.from(
        (map['places'] as List<int>).map<PlaceModel>(
          (x) => PlaceModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TourDetailsModel.fromJson(String source) =>
      TourDetailsModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, description, places];
}
