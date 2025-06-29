import 'dart:developer';

class TournamentsResponse {
  final String status;
  final int results;
  final List<Tournament>? tournaments;

  TournamentsResponse({
    required this.status,
    required this.results,
    required this.tournaments,
  });

  factory TournamentsResponse.fromJson(Map<String, dynamic> json) {
    return TournamentsResponse(
      status: json['status'],
      results: json['results'],
      tournaments: List<Tournament>.from(
        json['tournaments'].map((t) => Tournament.fromJson(t)),
      ),
    );
  }
}

class Tournament {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int maxTeams;
  final List<Field> fieldIds;
  final bool isPrivate;
  final String? institution;
  final String createdBy;
  final List<Team> teams;
  final String type;
  final String status;
  final String? winner;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.maxTeams,
    required this.fieldIds,
    required this.isPrivate,
    this.institution,
    required this.createdBy,
    required this.teams,
    required this.type,
    required this.status,
    required this.winner,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      maxTeams: json['max_teams'],
      fieldIds: List<Field>.from(
        json['field_ids'].map((f) => Field.fromJson(f)),
      ),
      isPrivate: json['is_private'],
      institution: json['institution'],
      createdBy: json['createdBy'],
      teams: List<Team>.from(json['teams'].map((t) => Team.fromJson(t))),
      type: json['type'],
      status: json['status'],
      winner: json['winner'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class Field {
  final String id;
  final String name;
  final String city;
  final String country;
  final int capacity;
  final bool isPaid;
  final int pricePerHour;
  final String? image;
  final String? locationInfo;
  final String? owner;
  final List<Amenity>? amenities;
  final Location location;
  final int v;

  Field({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.capacity,
    required this.isPaid,
    required this.pricePerHour,
    this.image,
    this.locationInfo,
    this.owner,
    this.amenities,
    required this.location,
    required this.v,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['_id'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
      capacity: json['capacity'],
      isPaid: json['is_paid'],
      pricePerHour: json['price_per_hour'],
      image: json['image'],
      locationInfo: json['location_info'],
      owner: json['owner'],
      amenities: json['amenities'] != null
          ? List<Amenity>.from(
              json['amenities'].map((a) => Amenity.fromJson(a)),
            )
          : [],
      location: Location.fromJson(json['location']),
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
      coordinates: List<double>.from(
        json['coordinates'].map((c) => c.toDouble()),
      ),
    );
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

class Team {
  final String id;
  final String name;
  final String? logo;
  final List<String> members;
  final String createdBy;
  final String tournament;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Team({
    required this.id,
    required this.name,
    this.logo,
    required this.members,
    required this.createdBy,
    required this.tournament,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'],
      name: json['name'],
      logo: json['logo'],
      members: List<String>.from(json['members']),
      createdBy: json['createdBy'],
      tournament: json['tournament'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
