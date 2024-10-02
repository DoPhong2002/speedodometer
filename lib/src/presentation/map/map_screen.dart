import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/constants/app_colors.dart';


@RoutePage()
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? mapController;
  LatLng? _currentLocation;
  Marker? _marker;

  @override
  void initState() {
    super.initState();
    _listenToLocationChanges();
  }

  void _listenToLocationChanges() {
    final locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10,
    );

    Geolocator.getPositionStream(locationSettings: locationSettings).listen((Position position) {
      setState(() {
        _currentLocation = LatLng(position.latitude, position.longitude);
        _marker = Marker(
          markerId: MarkerId('current_location'),
          position: _currentLocation!,
        );
      });
      mapController?.moveCamera(CameraUpdate.newLatLng(_currentLocation!));
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Tracking'),
      ),
      body: _currentLocation == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _currentLocation!,
          zoom: 15,
        ),
        markers: _marker != null ? Set<Marker>.of([_marker!]) : {},
        circles: _currentLocation != null
            ? Set<Circle>.of([
          Circle(
            circleId: CircleId('current_location_circle'),
            center: _currentLocation!,
            radius: 30,
            fillColor: AppColors.blueOmeter,
            strokeColor:  AppColors.blueOmeter,
            strokeWidth: 1,
          ),
        ])
            : {},
      ),
    );
  }
}


