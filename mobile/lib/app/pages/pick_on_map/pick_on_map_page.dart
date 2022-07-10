import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:ftoast/ftoast.dart';
import 'package:latlong2/latlong.dart';
import 'package:turistando/app/core/components/appbar/common_appbar.dart';
import 'package:turistando/app/core/components/buttons/common_button.dart';
import 'package:turistando/app/core/di/locator.dart';
import 'package:turistando/app/core/store/location_store.dart';

class PickOnMapPage extends StatefulWidget {
  const PickOnMapPage({Key? key}) : super(key: key);

  @override
  State<PickOnMapPage> createState() => _PickOnMapPageState();
}

class _PickOnMapPageState extends State<PickOnMapPage> {
  final mapController = MapController();

  final locationStore = locator.get<LocationStore>();

  LatLng? selectedLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonAppBar(
        title: "Selecione a localização",
      ),
      body: Stack(
        children: [
          ValueListenableBuilder(
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
                  onTap: (_, LatLng latLng) {
                    setState(() {
                      selectedLocation = latLng;
                    });
                  },
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
                    markers: selectedLocation != null
                        ? [
                            Marker(
                              point: selectedLocation!,
                              builder: (context) {
                                return const Icon(
                                  Icons.location_pin,
                                  size: 40,
                                  color: Colors.red,
                                );
                              },
                            )
                          ]
                        : [],
                    builder: (context, markers) {
                      return const Icon(
                        Icons.location_pin,
                        size: 24,
                        color: Colors.red,
                      );
                    },
                  ),
                ],
              );
            },
          ),
          Positioned(
            bottom: MediaQuery.of(context).padding.bottom + 24,
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05,
              ),
              child: CommonButton(
                text: "CONTINUAR",
                onTap: () {
                  if (selectedLocation == null) {
                    FToast.toast(context, msg: "Clique no mapa para escolher a localização");
                  } else {
                    locationStore.setLocation(selectedLocation!);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
