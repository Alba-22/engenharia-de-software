// ignore_for_file: public_member_api_docs, sort_constructors_first
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
}
