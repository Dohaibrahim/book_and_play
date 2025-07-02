import 'dart:developer';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:book_and_play/core/widgets/app_button.dart';
import 'package:book_and_play/core/widgets/top_snackbar.dart';
import 'package:book_and_play/features/owner/add_field/presentation/widgets/search_bar_bloc_builder.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationViewBody extends StatefulWidget {
  const PickLocationViewBody({super.key});

  @override
  State<PickLocationViewBody> createState() => _PickLocationViewBodyState();
}

class _PickLocationViewBodyState extends State<PickLocationViewBody> {
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
      TopSnackBar.show(
        context,
        title: 'Warning',
        message: 'Please give permissions to the app.',
        contentType: ContentType.warning,
        color: Colors.orange,
      );
    }
  }

  Future<void> getLoactionData() async {
    locationData = await Geolocator.getCurrentPosition();
    log('location data : ${locationData.toString()}');
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
    markers = {};
    setState(() {});
  }

  Future<void> checkAndRequestLoactionService() async {
    isServiceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await Geolocator.openAppSettings();
      if (!isServiceEnabled) {
        log("Location service not enabled.");
        TopSnackBar.show(
          context,
          title: 'Warning',
          message: 'you have to enable your location first',
          contentType: ContentType.warning,
          color: Colors.orange,
        );
        return;
      }
    }
  }

  Future<bool> checkAndRequestLoactionPermission() async {
    permissionStatus = await Geolocator.checkPermission();
    log("Permission status before: $permissionStatus");
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
    _searchController.dispose();
    super.dispose();
  }

  final TextEditingController _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Stack(
      children: [
        GoogleMap(
          onMapCreated: (controller) async {
            setState(() {
              googleMapController = controller;
            });
            initMapStyle();
          },
          markers: markers,

          initialCameraPosition: initialCameraPosition,
          onTap: (LatLng tappedPoint) async {
            var markerIcon = await BitmapDescriptor.asset(
              ImageConfiguration(size: Size(35, 35)),
              'assets/icons/maps_marker_icon.png',
            );
            setState(() {
              userLatLng = tappedPoint;
              markers = {
                Marker(
                  icon: markerIcon,
                  markerId: MarkerId('selected_location'),
                  position: tappedPoint,
                  infoWindow: InfoWindow(title: 'Selected Location'),
                ),
              };
            });
            log(
              "User tapped: ${tappedPoint.latitude}, ${tappedPoint.longitude}",
            );
          },
        ),
        Positioned(
          top: 60,
          right: 0,
          left: 0,
          child: SearchBarBlocBuilder(
            searchController: _searchController,
            googleMapController: googleMapController,
          ),
        ),
        Positioned(
          top: screenHeight * 0.90,
          right: 10,
          left: 10,
          child: AppButton(
            onPressed: () {
              if (userLatLng != null) {
                log(
                  "User selected location: ${userLatLng.latitude}, ${userLatLng.longitude}",
                );
                Navigator.pop(context, userLatLng);
              }
            },
            text: 'owner_add_field.save_location'.tr(),
            textStyle: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ),
      ],
    );
  }
}
