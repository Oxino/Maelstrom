import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maelstrom/config.dart';
import 'package:maelstrom/models/business_model.dart';
import 'package:maelstrom/models/event_model.dart';
import 'package:maelstrom/repositories/business/business_repo.dart';
import 'package:maelstrom/repositories/event/event_repo.dart';
import 'package:maelstrom/widgets/base_text.dart';
import 'package:maelstrom/widgets/event_map.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final EventRepos _eventRepos = EventRepos();
  final BusinessRepo _businessRepos = BusinessRepo();
  CameraPosition _initialLocation =
      CameraPosition(target: LatLng(44.837789, -0.57918));
  late GoogleMapController mapController;

  late Position _currentPosition;

  Set<Marker> markers = {};
  Set<EventModel> events = {};

  final startAddressController = TextEditingController();
  final destinationAddressController = TextEditingController();

  final startAddressFocusNode = FocusNode();
  final desrinationAddressFocusNode = FocusNode();

  EventModel? currentEvent;

  late PolylinePoints polylinePoints;
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  changeMapMode() {
    getJsonFile("assets/map_style.json").then(setMapStyle);
  }

  Future<String> getJsonFile(String path) async {
    return await rootBundle.loadString(path);
  }

  void setMapStyle(String mapStyle) {
    mapController.setMapStyle(mapStyle);
  }

  // Method for retrieving the current location
  _getCurrentLocation() async {
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) async {
      setState(() {
        _currentPosition = position;
        print('CURRENT POS: $_currentPosition');
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(position.latitude, position.longitude),
              zoom: 13.0,
            ),
          ),
        );
      });
    }).catchError((e) {
      print(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  setCurrentEvent(EventModel event) {
    setState(() => {
          if (currentEvent != event)
            currentEvent = event
          else
            currentEvent = null
        });
  }

  createMarkers(MarkerId markerId, EventModel event, String address) async {
    List<Location> addressPlacemark = await locationFromAddress(address);
    Marker marker = Marker(
      markerId: markerId,
      // infoWindow: InfoWindow(title: event.name),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      position:
          LatLng(addressPlacemark[0].latitude, addressPlacemark[0].longitude),
      onTap: () => setCurrentEvent(event),
    );
    markers.add(marker);
  }

  initilizeMarkers(List<EventModel?> listEvent) {
    listEvent.forEach((event) {
      if (event != null) {
        Stream<BusinessModel> stream =
            _businessRepos.getCurrentBusiness(event.idBusiness);
        stream.listen((business) {
          MarkerId markerId = MarkerId(event.name);
          String address = business.address;
          createMarkers(markerId, event, address);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      width: width,
      child: Scaffold(
          key: _scaffoldKey,
          body: StreamBuilder<List<EventModel?>>(
              stream: _eventRepos.getTodayEvents([]),
              builder: ((context, snapshot) {
                if (!snapshot.hasData)
                  return Container(
                    child: BaseText(
                      TextType.bodyBoldText,
                      "Pas d'évènement corespondant a votre recherche",
                    ),
                  );
                initilizeMarkers(snapshot.data!);
                bool isEvent = currentEvent != null;
                return Stack(
                  children: <Widget>[
                    // Map View

                    GoogleMap(
                      // markers: {if (firstMarker != null) firstMarker},
                      markers: Set<Marker>.from(markers),
                      initialCameraPosition: _initialLocation,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal,
                      zoomGesturesEnabled: true,
                      zoomControlsEnabled: false,
                      polylines: Set<Polyline>.of(polylines.values),
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                        changeMapMode();
                      },
                    ),
                    // Show current location button
                    SafeArea(
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding: EdgeInsets.only(
                              right: 10.0, bottom: isEvent ? 240.0 : 15.0),
                          child: ClipOval(
                            child: Material(
                              color:
                                  ThemeColors.principaleColor, // button color
                              child: InkWell(
                                splashColor:
                                    ThemeColors.radientColor, // inkwell color
                                child: SizedBox(
                                  width: 56,
                                  height: 56,
                                  child: Icon(Icons.my_location),
                                ),
                                onTap: () {
                                  mapController.animateCamera(
                                    CameraUpdate.newCameraPosition(
                                      CameraPosition(
                                        target: LatLng(
                                          _currentPosition.latitude,
                                          _currentPosition.longitude,
                                        ),
                                        zoom: 13.0,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                        child: Align(
                      alignment: Alignment.bottomCenter,
                      child: EventMap(currentEvent),
                    ))
                  ],
                );
              }))),
    );
  }
}
