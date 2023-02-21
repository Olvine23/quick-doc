import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/core/utils/colors.dart';
import 'package:test/features/number_trivia/presentation/widgets/search_input.dart';
import 'package:http/http.dart' as http;

class HospitalScreen extends StatefulWidget {
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  List<dynamic> hospitals = [];
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};
  String? _currentAddress;
  Position? _currentPosition;
  LatLng? _center;

  late Position currentLocation;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  static final LatLng _kMapCenter = LatLng(0.2699067, 34.7244183);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

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

  void _addMarkers() {
    hospitals.asMap().forEach((index, hospital) {
      var markerIdVal = index.toString();
      final MarkerId markerId = MarkerId(markerIdVal);
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          hospital['geometry']['location']['lat'],
          hospital['geometry']['location']['lng'],
        ),
        infoWindow: InfoWindow(
          title: hospital['name'],
          snippet: hospital['vicinity'],
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
          markerId: MarkerId("Your Location",), 
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
  }

  @override
  Widget build(BuildContext context) {
    print(_currentPosition?.latitude);
    print(_currentPosition?.longitude);
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Hospitals Near Me'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          SearchInput(
            text: "Search for hospitals",
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              height: 400,
              child: GoogleMap(
                initialCameraPosition: _kInitialPosition,
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
