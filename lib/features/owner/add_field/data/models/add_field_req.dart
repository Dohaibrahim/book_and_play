import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';

class AddFieldRequest {
  final String name;
  final File imageFile;
  final String country;
  final String city;
  final int capacity;
  final String isPaid;
  final int pricePerHour;
  final Location location;
  final String locationInfo;
  //final List<Amenities> amenities;

  AddFieldRequest({
    required this.name,
    required this.imageFile,
    required this.country,
    required this.city,
    required this.capacity,
    required this.isPaid,
    required this.pricePerHour,
    required this.location,
    required this.locationInfo,
    //required this.amenities,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': name,
      'image': await MultipartFile.fromFile(
        imageFile.path,
        filename: imageFile.path.split('/').last,
      ),
      'country': country,
      'city': city,
      'capacity': capacity.toString(),
      'is_paid': isPaid,
      'price_per_hour': pricePerHour.toString(),
      'location': location.toJson(), // String-encoded JSON
      'location_info': locationInfo,
      /*'amenities': jsonEncode(
        amenities.map((e) => e.toJson()).toList(),
      ),*/
      // String-encoded JSON
    });
  }
}

class Location {
  final List<double> coordinates;

  Location({required this.coordinates});

  // Convert to Map that can be JSON encoded
  /*String toJson() {
    return jsonEncode({"type": type, "coordinates": coordinates}).toString();
  }*/
  Map<String, dynamic> toJson() {
    return {'type': 'Point', 'coordinates': coordinates};
  }

  String toRawJsonString() {
    return jsonEncode(toJson());
  }
}

class Amenities {
  bool parking = false;
  bool ballRent = false;
  bool toilets = false;
  bool changingRooms = false;
  bool cafeteria = false;
  bool lightingQuality = false;
  bool fieldQuality = false;

  Amenities({
    required this.parking,
    required this.ballRent,
    required this.toilets,
    required this.changingRooms,
    required this.cafeteria,
    required this.lightingQuality,
    required this.fieldQuality,
  });

  Map<String, dynamic> toJson() {
    return {
      'parking': parking,
      'ball_rent': ballRent,
      'toilets': toilets,
      'changing_rooms': changingRooms,
      'cafeteria': cafeteria,
      'lighting_quality': lightingQuality,
      'field_quality': fieldQuality,
    };
  }
}
