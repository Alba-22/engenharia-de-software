import 'package:flutter/cupertino.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/utils/constants.dart';

class LocationStore extends ValueNotifier<LatLng> {
  final LocalStorageService _localStorage;

  LocationStore(this._localStorage) : super(initialLocation) {
    _init();
  }

  Future<void> _init() async {
    final LatLng? latLng = await _recoverLocationFromStorage();
    if (latLng == null) {
      getUserLocation();
    } else {
      value = latLng;
    }
  }

  void setLocation(LatLng newLocation) {
    value = newLocation;
    _writeLocationToStorage(newLocation);
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
    _writeLocationToStorage(value);
    notifyListeners();
  }

  Future<void> _writeLocationToStorage(LatLng latLng) async {
    await _localStorage.write(StorageKeys.lastLocationLatitude, latLng.latitude.toString());
    await _localStorage.write(StorageKeys.lastLocationLongitude, latLng.longitude.toString());
  }

  Future<LatLng?> _recoverLocationFromStorage() async {
    final latitudeStr = await _localStorage.read(StorageKeys.lastLocationLatitude);
    final longitudeStr = await _localStorage.read(StorageKeys.lastLocationLongitude);
    if (latitudeStr == null || longitudeStr == null) {
      return null;
    }
    final latLng = LatLng(
      double.parse(latitudeStr),
      double.parse(longitudeStr),
    );
    return latLng;
  }
}
