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
  final String imageUrl;
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
    required this.imageUrl,
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
      imageUrl,
      rate,
    ];
  }
}
