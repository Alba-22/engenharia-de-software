import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:turistando/app/core/utils/constants.dart';

class LocationStore extends ValueNotifier<LatLng> {
  LocationStore() : super(initialLocation) {
    getUserLocation();
  }

  void setLocation(LatLng newLocation) {
    value = newLocation;
    notifyListeners();
  }

  Future<void> getUserLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();

    value = LatLng(
      locationData.latitude ?? initialLocation.latitude,
      locationData.longitude ?? initialLocation.longitude,
    );
    notifyListeners();
  }
}
