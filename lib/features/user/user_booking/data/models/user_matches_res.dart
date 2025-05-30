class UserMatchesResponse {
  final String message;
  final List<UserMatchModel> matches;

  UserMatchesResponse({required this.message, required this.matches});

  factory UserMatchesResponse.fromJson(Map<String, dynamic> json) {
    return UserMatchesResponse(
      message: json['message'],
      matches:
          (json['matches'] as List)
              .map((match) => UserMatchModel.fromJson(match))
              .toList(),
    );
  }
}

class UserMatchModel {
  final MatchTime time;
  final GeoLocation location;
  final String id;
  final Field field;
  final DateTime date;
  final int maxPlayers;
  final List<String> currentPlayers;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserMatchModel({
    required this.time,
    required this.location,
    required this.id,
    required this.field,
    required this.date,
    required this.maxPlayers,
    required this.currentPlayers,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserMatchModel.fromJson(Map<String, dynamic> json) {
    return UserMatchModel(
      time: MatchTime.fromJson(json['time']),
      location: GeoLocation.fromJson(json['location']),
      id: json['_id'],
      field: Field.fromJson(json['fieldId']),
      date: DateTime.parse(json['date']),
      maxPlayers: json['max_players'],
      currentPlayers: List<String>.from(json['current_players']),
      status: json['status'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class MatchTime {
  final String start;
  final String end;

  MatchTime({required this.start, required this.end});

  factory MatchTime.fromJson(Map<String, dynamic> json) {
    return MatchTime(start: json['start'], end: json['end']);
  }
}

class Field {
  final GeoLocation location;
  final String id;
  final String name;
  final String city;
  final String country;
  final int capacity;
  final bool isPaid;
  final int pricePerHour;
  final List<dynamic> amenities;

  Field({
    required this.location,
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.capacity,
    required this.isPaid,
    required this.pricePerHour,
    required this.amenities,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      location: GeoLocation.fromJson(json['location']),
      id: json['_id'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
      capacity: json['capacity'],
      isPaid: json['is_paid'],
      pricePerHour: json['price_per_hour'],
      amenities: json['amenities'] ?? [],
    );
  }
}

class GeoLocation {
  final String type;
  final List<double> coordinates;

  GeoLocation({required this.type, required this.coordinates});

  factory GeoLocation.fromJson(Map<String, dynamic> json) {
    return GeoLocation(
      type: json['type'],
      coordinates: List<double>.from(
        json['coordinates'].map((e) => e.toDouble()),
      ),
    );
  }
}
