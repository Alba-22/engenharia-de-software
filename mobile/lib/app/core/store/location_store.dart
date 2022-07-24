import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:turistando/app/core/models/location_model.dart';
import 'package:turistando/app/core/services/local_storage/local_storage_service.dart';
import 'package:turistando/app/core/utils/constants.dart';

class LocationStore extends ValueNotifier<LocationModel> {
  final LocalStorageService _localStorage;

  LocationStore(this._localStorage) : super(initialLocation) {
    _init();
  }

  Future<void> _init() async {
    final LocationModel? lastLocation = await _recoverLocationFromStorage();
    if (lastLocation == null) {
      getUserLocation();
    } else {
      setLocation(lastLocation);
    }
  }

  void setLocation(LocationModel newLocation) {
    value = newLocation;
    _writeLocationToStorage(newLocation);
    notifyListeners();
  }

  Future<void> setLocationFromLatLng(LatLng latLng) async {
    final cityName = await _getCityFromLatLng(latLng.latitude, latLng.longitude);
    final newLocation = LocationModel(
      latitude: latLng.latitude,
      longitude: latLng.longitude,
      cityName: cityName ?? "",
    );
    setLocation(newLocation);
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

    if (locationData.latitude != null && locationData.longitude != null) {
      final cityName = await _getCityFromLatLng(locationData.latitude!, locationData.longitude!);
      if (cityName != null) {
        final newLocation = LocationModel(
          latitude: locationData.latitude!,
          longitude: locationData.longitude!,
          cityName: cityName,
        );
        setLocation(newLocation);
      }
    }
  }

  Future<void> _writeLocationToStorage(LocationModel location) async {
    await _localStorage.write(StorageKeys.lastLocation, location.toJson());
  }

  /// Try to get last location of a user from Local Storage.
  ///
  /// Returns null if the information is not on Local Storage.
  /// This will happen mostly in first access to the app.
  Future<LocationModel?> _recoverLocationFromStorage() async {
    final lastLocation = await _localStorage.read(StorageKeys.lastLocation);
    if (lastLocation == null) {
      return null;
    }
    return LocationModel.fromJson(lastLocation);
  }

  Future<String?> _getCityFromLatLng(double latitude, double longitude) async {
    final List<Placemark> placemarks = await placemarkFromCoordinates(
      latitude,
      longitude,
    );

    final location = placemarks.first;

    return location.subAdministrativeArea?.toUpperCase();
  }
}
