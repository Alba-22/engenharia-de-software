// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlaceModel extends Equatable {
  final String id;
  final String name;
  final String formattedAddress;
  final String district;
  final String city;
  final String state;
  final double latitude;
  final double longitude;
  final String description;
  final List<String> images;
  final int rate;

  const PlaceModel({
    required this.id,
    required this.name,
    required this.formattedAddress,
    required this.district,
    required this.city,
    required this.state,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.images,
    required this.rate,
  });

  @override
  List<Object> get props {
    return [
      id,
      name,
      formattedAddress,
      district,
      city,
      state,
      latitude,
      longitude,
      description,
      images,
      rate,
    ];
  }

  @override
  bool get stringify => true;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'formatted_address': formattedAddress,
      'district': district,
      'city': city,
      'state': state,
      'latitude': latitude,
      'longitude': longitude,
      'images': images,
      'description': description,
      'rate': rate,
    };
  }

  factory PlaceModel.fromMap(Map<String, dynamic> map) {
    return PlaceModel(
      id: map['id'] as String,
      name: map['name'] as String,
      formattedAddress: map['formatted_address'] as String,
      district: map['district'] as String,
      city: map['city'] as String,
      state: map['state'] as String,
      latitude: map['latitude'] as double,
      longitude: map['longitude'] as double,
      description: map['description'] as String,
      images: List.from((map['images'])),
      rate: map['rate'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory PlaceModel.fromJson(String source) =>
      PlaceModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
