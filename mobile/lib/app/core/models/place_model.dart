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

  const PlaceModel({
    required this.id,
    required this.name,
    required this.formattedAddress,
    required this.district,
    required this.city,
    required this.state,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object?> get props =>
      [id, name, formattedAddress, district, city, state, latitude, longitude];
}
