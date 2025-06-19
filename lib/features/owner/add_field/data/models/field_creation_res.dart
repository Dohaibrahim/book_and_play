class FieldCreationResponse {
  final String message;
  final FieldCreated field;

  FieldCreationResponse({required this.message, required this.field});

  factory FieldCreationResponse.fromJson(Map<String, dynamic> json) {
    return FieldCreationResponse(
      message: json['message'],
      field: FieldCreated.fromJson(json['field']),
    );
  }
}

class FieldCreated {
  final String id;
  final String name;
  final String city;
  final String country;
  final int capacity;
  final bool isPaid;
  final int pricePerHour;
  final Location location;
  final String locationInfo;
  final List<Amenities> amenities;
  final String owner;
  final int v;

  FieldCreated({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.capacity,
    required this.isPaid,
    required this.pricePerHour,
    required this.location,
    required this.locationInfo,
    required this.amenities,
    required this.owner,
    required this.v,
  });

  factory FieldCreated.fromJson(Map<String, dynamic> json) {
    return FieldCreated(
      id: json['_id'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
      capacity: json['capacity'],
      isPaid: json['is_paid'],
      pricePerHour: json['price_per_hour'],
      location: Location.fromJson(json['location']),
      locationInfo: json['location_info'],
      amenities: (json['amenities'] as List)
          .map((e) => Amenities.fromJson(e))
          .toList(),
      owner: json['owner'],
      v: json['__v'],
    );
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'],
      coordinates: List<double>.from(json['coordinates']),
    );
  }
}

class Amenities {
  final bool parking;
  final bool ballRent;
  final bool toilets;
  final bool changingRooms;
  final bool cafeteria;
  final bool lightingQuality;
  final bool fieldQuality;
  final String id;

  Amenities({
    required this.parking,
    required this.ballRent,
    required this.toilets,
    required this.changingRooms,
    required this.cafeteria,
    required this.lightingQuality,
    required this.fieldQuality,
    required this.id,
  });

  factory Amenities.fromJson(Map<String, dynamic> json) {
    return Amenities(
      parking: json['parking'],
      ballRent: json['ball_rent'],
      toilets: json['toilets'],
      changingRooms: json['changing_rooms'],
      cafeteria: json['cafeteria'],
      lightingQuality: json['lighting_quality'],
      fieldQuality: json['field_quality'],
      id: json['_id'],
    );
  }
}
