class AllFieldsRes {
  final String message;
  final List<Field> fields;

  AllFieldsRes({required this.fields, required this.message});

  factory AllFieldsRes.fromJson(Map<String, dynamic> json) {
    var fieldsFromJson = json['fields'] as List;
    List<Field> fieldsList = fieldsFromJson
        .map((i) => Field.fromJson(i))
        .toList();
    return AllFieldsRes(fields: fieldsList, message: json['message']);
  }
}

class Field {
  final Location location;
  final String id, name, city, country;
  final List<Amenities> amenities;
  final bool isPaid;
  final int capacity;
  final int? pricePerHour;

  Field({
    required this.location,
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.capacity,
    required this.isPaid,
    required this.amenities,
    this.pricePerHour,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      location: Location.fromJson(json['location']),
      id: json['_id'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
      capacity: json['capacity'],
      isPaid: json['is_paid'],
      amenities: (json['amenities'] as List)
          .map((a) => Amenities.fromJson(a))
          .toList(),
      pricePerHour: json['price_per_hour'],
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
    this.parking = false,
    this.ballRent = false,
    this.toilets = false,
    this.changingRooms = false,
    this.cafeteria = false,
    this.lightingQuality = false,
    this.fieldQuality = false,
    required this.id,
  });

  factory Amenities.fromJson(Map<String, dynamic> json) {
    return Amenities(
      parking: json['parking'] ?? false,
      ballRent: json['ball_rent'] ?? false,
      toilets: json['toilets'] ?? false,
      changingRooms: json['changing_rooms'] ?? false,
      cafeteria: json['cafeteria'] ?? false,
      lightingQuality: json['lighting_quality'] ?? false,
      fieldQuality: json['field_quality'] ?? false,
      id: json['_id'],
    );
  }
}

class Location {
  final String type;
  final List<dynamic> coordinates;

  Location({required this.coordinates, required this.type});

  factory Location.fromJson(Map<String, dynamic> json) {
    var coordinatesFromJson = json['coordinates'] as List;
    //List<dynamic> coordinateList = coordinatesFromJson.map((i) => ).toList();
    return Location(coordinates: coordinatesFromJson, type: json['type']);
  }
}
