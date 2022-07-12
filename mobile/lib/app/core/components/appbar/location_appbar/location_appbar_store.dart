import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:latlong2/latlong.dart';

class LocationAppbarStore extends ValueNotifier<String> {
  LocationAppbarStore() : super("");

  Future<void> getCityFromLatLng(LatLng latLng) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      latLng.latitude,
      latLng.longitude,
    );

    final location = placemarks.first;

    value = "${location.subAdministrativeArea?.toUpperCase() ?? ""} - ${location.isoCountryCode}";
  }
}
