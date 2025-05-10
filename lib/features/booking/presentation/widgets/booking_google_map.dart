import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BookingGoogleMap extends StatefulWidget {
  const BookingGoogleMap({super.key});

  @override
  State<BookingGoogleMap> createState() => _BookingGoogleMapState();
}

class _BookingGoogleMapState extends State<BookingGoogleMap> {
  late CameraPosition initialCameraPosition;
  GoogleMapController? googleMapController;
  Set<Marker> markers = {};
  late bool isServiceEnabled;
  LocationPermission? permissionStatus;
  Position? locationData;
  LatLng userLatLng = LatLng(31.2001, 29.9187);

  @override
  void initState() {
    initLocationAndMap();

    initialCameraPosition = CameraPosition(zoom: 13, target: userLatLng);
    initMarkers();
    super.initState();
  }

  Future<void> initLocationAndMap() async {
    await checkAndRequestLoactionService();
    bool hasPermission = await checkAndRequestLoactionPermission();
    if (hasPermission) {
      await getLoactionData();
    } else {
      //TODO: notify user that he hasn't enable permission
    }
  }

  Future<void> getLoactionData() async {
    locationData = await Geolocator.getCurrentPosition();
    log('location data : ${locationData.toString()}');
    //locationData == null ? '' :
    userLatLng = LatLng(locationData!.latitude, locationData!.longitude);
    googleMapController?.animateCamera(CameraUpdate.newLatLng(userLatLng));
  }

  void initMapStyle() async {
    var lightMapStyle = await DefaultAssetBundle.of(
      context,
    ).loadString('assets/map_styles/light_map_style.json');
    googleMapController!.setMapStyle(lightMapStyle);
  }

  void initMarkers() async {
    var markerIcon = await BitmapDescriptor.asset(
      ImageConfiguration(size: Size(35, 35)),
      'assets/icons/maps_marker_icon.png',
    );

    Marker marker = Marker(
      icon: markerIcon,
      markerId: MarkerId('1'),
      position: LatLng(31.2001, 29.9187),
    );

    markers = {
      Marker(
        infoWindow: InfoWindow(
          anchor: Offset(0, 1),
          title: 'Marker Title',
          snippet: 'More details here',
          onTap: () {
            // optional: navigate or perform action
          },
        ),
        icon: markerIcon,
        markerId: MarkerId('1'),
        position: LatLng(31.2001, 29.9187),
      ),
    };
    setState(() {});
  }

  Future<void> checkAndRequestLoactionService() async {
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await Geolocator.openAppSettings();
      if (!isServiceEnabled) {
        log("Location service not enabled.");
        return;
        //TODO: show error bar to make him go to settings>> enable location
      }
    }
  }

  Future<bool> checkAndRequestLoactionPermission() async {
    permissionStatus = await Geolocator.checkPermission();
    log("Permission status before: $permissionStatus");
    //log(permissionStatus.toString());
    if (permissionStatus == LocationPermission.deniedForever) {
      return false;
    } else if (permissionStatus == LocationPermission.denied) {
      permissionStatus = await Geolocator.requestPermission();
      if (permissionStatus == LocationPermission.denied) {
        return false;
      }
    }
    return true;
  }

  @override
  void dispose() {
    googleMapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) async {
            googleMapController = controller;
            initMapStyle();
          },
          markers: markers,
          initialCameraPosition: initialCameraPosition,
        ),
        /*Center(
          child: MaterialButton(
            onPressed: () async {
              CameraPosition newCameraPos = CameraPosition(
                zoom: 10,

                target: LatLng(31.2001, 29.9187),
              );
              LatLng newLatLng = LatLng(31.2001, 29.9187);

              setState(() {});
              googleMapController!.animateCamera(
                CameraUpdate.newLatLng(newLatLng),
              );
            },
            color: Colors.green,
            child: Text('click meeee'),
          ),
        ),*/
      ],
    );
  }
}
