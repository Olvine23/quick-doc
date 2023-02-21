import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test/core/styles/styles.dart';
import 'package:test/features/number_trivia/presentation/widgets/search_input.dart';

class HospitalScreen extends StatefulWidget {
  @override
  _HospitalScreenState createState() => _HospitalScreenState();
}

class _HospitalScreenState extends State<HospitalScreen> {
  String? _currentAddress;
  Position? _currentPosition;
  GoogleMapController? _mapController;
  final Set<Marker> _markers = {};

  static final LatLng _kMapCenter = LatLng(0.2699067, 34.7244183);

  static final CameraPosition _kInitialPosition =
      CameraPosition(target: _kMapCenter, zoom: 11.0, tilt: 0, bearing: 0);

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
          markerId: MarkerId("Your Location"),
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
    _getCurrentLocation();
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
            height: 90,
          ),
          Expanded(
            child: Container(
              height: 400,
              child: GoogleMap(
                  initialCameraPosition: _kInitialPosition,
                  myLocationEnabled: true,
                  markers: {
                    Marker(
                        markerId: MarkerId('My Location'),
                        position: _kMapCenter),
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
