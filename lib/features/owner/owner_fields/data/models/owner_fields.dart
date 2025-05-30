class FieldResponse {
  final String message;
  final List<OwnerField> fields;

  FieldResponse({required this.message, required this.fields});

  factory FieldResponse.fromJson(Map<String, dynamic> json) {
    return FieldResponse(
      message: json['message'],
      fields: List<OwnerField>.from(
        json['fields'].map((x) => OwnerField.fromJson(x)),
      ),
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
  final double pricePerHour;
  final String owner;
  final List<dynamic> amenities;
  final Location location;

  OwnerField({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.capacity,
    required this.isPaid,
    required this.pricePerHour,
    required this.owner,
    required this.amenities,
    required this.location,
  });

  factory OwnerField.fromJson(Map<String, dynamic> json) {
    return OwnerField(
      id: json['_id'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
      capacity: json['capacity'],
      isPaid: json['is_paid'],
      pricePerHour: (json['price_per_hour'] as num).toDouble(),
      owner: json['owner'],
      amenities: json['amenities'],
      location: Location.fromJson(json['location']),
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
      coordinates: List<double>.from(
        json['coordinates'].map((x) => x.toDouble()),
      ),
    );
  }
}
