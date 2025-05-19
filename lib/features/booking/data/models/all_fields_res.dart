class AllFieldsRes {
  final String message;
  final List<Field> fields;

  AllFieldsRes({required this.fields, required this.message});

  factory AllFieldsRes.fromJson(Map<String, dynamic> json) {
    var fieldsFromJson = json['fields'] as List;
    List<Field> fieldsList =
        fieldsFromJson.map((i) => Field.fromJson(i)).toList();
    return AllFieldsRes(fields: fieldsList, message: json['message']);
  }
}

class Field {
  final Location location;
  final String id, name, city, country;
  final List<dynamic> amenities;
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
      amenities: json['amenities'],
      pricePerHour: json['price_per_hour'],
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
