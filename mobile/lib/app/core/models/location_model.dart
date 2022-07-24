// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class LocationModel extends Equatable {
  final double latitude;
  final double longitude;
  final String cityName;

  const LocationModel({
    required this.latitude,
    required this.longitude,
    required this.cityName,
  });

  LocationModel copyWith({
    double? latitude,
    double? longitude,
    String? cityName,
  }) {
    return LocationModel(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      cityName: cityName ?? this.cityName,
    );
  }

  LatLng get latLng => LatLng(latitude, longitude);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'latitude': latitude,
      'longitude': longitude,
      'cityName': cityName,
    };
  }

  factory LocationModel.fromMap(Map<String, dynamic> map) {
    return LocationModel(
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      cityName: map['cityName'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LocationModel.fromJson(String source) => LocationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [latitude, longitude, cityName];

  @override
  bool get stringify => true;
}
