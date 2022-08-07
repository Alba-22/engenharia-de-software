import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:turistando/app/core/components/appbar/location_appbar/location_appbar.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/models/location_model.dart';
import 'package:turistando/app/core/store/location_store.dart';
import 'package:turistando/app/core/store/places_store.dart';

import 'components/place_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mapController = MapController();
  final locationStore = locator.get<LocationStore>();
  final placesStore = locator.get<PlacesStore>();

  List<Marker> markers = [];

  @override
  void initState() {
    super.initState();
    locationStore.addListener(() {
      placesStore.getAllPlacesByCityName(locationStore.value.cityName);
      mapController.move(locationStore.value.latLng, 14);
    });
    placesStore.observer(
      onState: (state) {
        markers = state.map((place) {
          return Marker(
            point: LatLng(place.latitude, place.longitude),
            builder: (context) {
              return InkWell(
                onTap: () {
                  placeDialog(context, place);
                },
                child: const Icon(
                  Icons.location_pin,
                  color: Colors.red,
                  size: 40,
                ),
              );
            },
          );
        }).toList();
        setState(() {});
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LocationAppBar(),
      body: ValueListenableBuilder(
        valueListenable: locationStore,
        builder: (context, LocationModel location, child) {
          return FlutterMap(
            options: MapOptions(
              center: location.latLng,
              zoom: 14,
              allowPanning: false,
              maxBounds: LatLngBounds(
                LatLng(-90, -180.0),
                LatLng(90.0, 180.0),
              ),
              rotationWinGestures: MultiFingerGesture.none,
              enableMultiFingerGestureRace: true,
              plugins: [
                MarkerClusterPlugin(),
              ],
            ),
            mapController: mapController,
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
              MarkerClusterLayerOptions(
                markers: markers,
                builder: (context, markers) {
                  // TODO: Fazer dar zoom quando clicar em um marker que é cluster
                  return const Icon(
                    Icons.location_pin,
                    color: Colors.red,
                    size: 20,
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}