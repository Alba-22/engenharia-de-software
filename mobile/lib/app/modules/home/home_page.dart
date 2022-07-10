import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:turistando/app/core/components/appbar/location_appbar.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/services/location_store.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final mapController = MapController();
  final locationStore = locator.get<LocationStore>();

  @override
  void initState() {
    super.initState();
    locationStore.addListener(() {
      mapController.move(locationStore.value, 14);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const LocationAppBar(),
      body: ValueListenableBuilder(
        valueListenable: locationStore,
        builder: (context, LatLng location, child) {
          return FlutterMap(
            options: MapOptions(
              center: location,
              zoom: 14,
              allowPanning: false,
              maxBounds: LatLngBounds(
                LatLng(-90, -180.0),
                LatLng(90.0, 180.0),
              ),
              rotationWinGestures: MultiFingerGesture.none,
              enableMultiFingerGestureRace: true,
            ),
            mapController: mapController,
            layers: [
              TileLayerOptions(
                urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c'],
              ),
            ],
          );
        },
      ),
    );
  }
}
