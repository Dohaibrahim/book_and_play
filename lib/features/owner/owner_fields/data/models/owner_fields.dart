class FieldResponse {
  final String message;
  final List<OwnerField> fields;

  FieldResponse({required this.message, required this.fields});

  factory FieldResponse.fromJson(Map<String, dynamic> json) {
    return FieldResponse(
      message: json['message'],
      fields: (json['fields'] as List)
          .map((item) => OwnerField.fromJson(item))
          .toList(),
    );
  }
}

class OwnerField {
  final String id;
  final String name;
  final String city;
  final String country;
  final int capacity;
  final bool isPaid;
  final int pricePerHour;
  final String owner;
  final String? image;
  final String? locationInfo;
  final Location location;
  final List<Amenity> amenities;

  OwnerField({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.capacity,
    required this.isPaid,
    required this.pricePerHour,
    required this.owner,
    required this.location,
    this.image,
    this.locationInfo,
    required this.amenities,
  });

  factory OwnerField.fromJson(Map<String, dynamic> json) {
    return OwnerField(
      id: json['_id'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
      capacity: json['capacity'],
      isPaid: json['is_paid'],
      pricePerHour: json['price_per_hour'],
      owner: json['owner'],
      image: json['image'],
      locationInfo: json['location_info'],
      location: Location.fromJson(json['location']),
      amenities: (json['amenities'] as List)
          .map((item) => Amenity.fromJson(item))
          .toList(),
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
      coordinates: (json['coordinates'] as List)
          .map((e) => (e as num).toDouble())
          .toList(),
    );
  }
  Map<String, dynamic> toJson() {
    return {'type': type, 'coordinates': coordinates};
  }
}

class Amenity {
  final bool? parking;
  final bool? ballRent;
  final bool? toilets;
  final bool? changingRooms;
  final bool? cafeteria;
  final bool? lightingQuality;
  final bool? fieldQuality;
  final String id;

  Amenity({
    this.parking,
    this.ballRent,
    this.toilets,
    this.changingRooms,
    this.cafeteria,
    this.lightingQuality,
    this.fieldQuality,
    required this.id,
  });

  factory Amenity.fromJson(Map<String, dynamic> json) {
    return Amenity(
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
