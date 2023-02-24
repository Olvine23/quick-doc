// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'dart:convert';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/core/styles/colors.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/widgets/search_input.dart';
import 'package:http/http.dart' as http;

class HospitalScreen extends StatefulWidget {
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  List<dynamic> hospitals = [];
  final Completer<GoogleMapController> _controller = Completer();
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String? _currentAddress;
  Position? _currentPosition;
  LatLng? _center;
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  late Position currentLocation;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  static final LatLng _kMapCenter = LatLng(0.2699067, 34.7244183);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 15.0, tilt: 0, bearing: 0);

  Future<void> _getLocation() async {
    currentLocation = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _center = LatLng(currentLocation.latitude, currentLocation.longitude);
    });
  }

  Future<void> _getHospitals() async {
    print(_center!.latitude);
    print(_center!.longitude);
    String url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_center!.latitude},${_center!.longitude}&radius=15000&type=hospital&key=AIzaSyCYinXlTBVd27JW6sHe3xixPmOfNPTdo7E';
    var response = await http.get(Uri.parse(url));
    Map<String, dynamic> data = json.decode(response.body);
    setState(() {
      hospitals = data['results'];
    });

    _addMarkers();
  }

  void addCustomIcon() async {
    await BitmapDescriptor.fromAssetImage(
            const ImageConfiguration(), "assets/hospital.png")
        .then(
      (icon) {
        setState(() {
          markerIcon = icon;
        });
      },
    );
  }

  void _addMarkers() {
    hospitals.asMap().forEach((index, hospital) {
      var markerIdVal = index.toString();
      final MarkerId markerId = MarkerId(markerIdVal);
      final Marker marker = Marker(
        icon: markerIcon,
        markerId: markerId,
        position: LatLng(
          hospital['geometry']['location']['lat'],
          hospital['geometry']['location']['lng'],
        ),
        infoWindow: InfoWindow(
          title: hospital['name'],
          snippet: hospital['vicinity'],
          onTap: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return Container(
                    height: 150,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('${hospital['name']}', style: kTitleStyle),
                          SizedBox(
                            height: 10,
                          ),
                          Text('${hospital['vicinity']} ',
                              style: kTitleStyleWithColor),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            hospital['business_status'],
                            style: TextStyle(fontSize: 8),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          if (hospital['rating'] == null)
                            Text(
                              "Hospital facility has no rating",
                              style: TextStyle(color: Colors.red, fontSize: 15),
                            )
                          else if (hospital['rating'] <= 1.9)
                            Icon(Icons.star)
                          else if (hospital['rating'] <= 2.9)
                            Expanded(
                              child: Row(children: const [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                ),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                )
                              ]),
                            )
                          else if (hospital['rating'] <= 3.9)
                            // ignore: prefer_const_literals_to_create_immutables
                            Row(children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ])
                          else if (hospital['rating'] <= 4.9)
                            Row(children: const [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ])
                          else if (hospital['rating'] <= 5)
                            Row(children: const [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                              )
                            ]),
                          // Text(hospital['rating'].toString()),
                        ],
                      ),
                    ),
                  );
                });
          },
        ),
      );
      markers[markerId] = marker;
    });
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  void _getCurrentLocation() async {
    final Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;
      _markers.add(Marker(
          icon: markerIcon,
          markerId: MarkerId(
            "Your Location",
          ),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(title: "Your Location")));
    });
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  void initState() {
    super.initState();
    _getLocation().then((value) => _getHospitals());
    addCustomIcon();
  }

  @override
  Widget build(BuildContext context) {
    print(_currentPosition?.latitude);
    print(_currentPosition?.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hospitals Near Me'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AvatarGlow(
                  glowColor: Colors.yellow,
                  endRadius: 25,
                  child: Icon(
                    Icons.tips_and_updates,
                    color: Colors.yellow,
                  )),
              Expanded(
                child: Text(
                  "Click on the hospital icon 🏥 for more details",
                  style: kTitleStyle,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: SizedBox(
              height: 500,
              child: GoogleMap(
                initialCameraPosition: _kInitialPosition,
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
                myLocationEnabled: true,
                markers: Set<Marker>.of(markers.values),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
