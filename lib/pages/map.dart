import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapPage extends StatelessWidget {
  late GoogleMapController mapController;

  final LatLng _center = const LatLng(44.837789, -0.57918);
  bool isMapCreated = false;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    isMapCreated = true;
    changeMapMode();
  }

  changeMapMode() {
    getJsonFile("assets/map_style.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    mapController.setMapStyle(mapStyle);
  }

  @override
  Widget build(BuildContext context) {
    if (isMapCreated) {
      changeMapMode();
    }
    return GoogleMap(
      onMapCreated: _onMapCreated,
      myLocationButtonEnabled: false,
      // gestureRecognizers: Set()
      //   ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer())),
      zoomControlsEnabled: false,
      initialCameraPosition: CameraPosition(
        target: _center,
        zoom: 13.0,
      ),
    );
  }
}
