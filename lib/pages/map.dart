import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:maelstrom/config.dart';
// import 'package:maelstrom/pages/base_page.dart';
// import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/base_navigation_bar.dart';

import 'package:maelstrom/widgets/base_app_bar.dart';

// class MapPage extends BasePage {
//   late GoogleMapController mapController;

//   final LatLng _center = const LatLng(45.521563, -122.677433);

//   void _onMapCreated(GoogleMapController controller) {
//     mapController = controller;
//   }

//   MapPage()
//       : super(
//           appBar: BaseAppBar('test'),
//           body: GoogleMap(
//             onMapCreated: _onMapCreated,
//             initialCameraPosition: CameraPosition(
//               target: _center,
//               zoom: 11.0,
//             ),
//           ),
//         );
// }

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
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: BaseAppBar('', Colors.transparent),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 13.0,
        ),
      ),
      bottomNavigationBar: BaseNavigationBar(),
    );
  }
}
