class GetTournamentsRes {
  final String message;
  final List<Tournament> tournaments;

  GetTournamentsRes({required this.message, required this.tournaments});

  factory GetTournamentsRes.fromJson(Map<String, dynamic> json) {
    return GetTournamentsRes(
      message: json['message'],
      tournaments: (json['tournaments'] as List)
          .map((e) => Tournament.fromJson(e))
          .toList(),
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
  final CreatedBy createdBy;
  final List<String> teams;
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
    this.winner,
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
      fieldIds: (json['field_ids'] as List)
          .map((f) => Field.fromJson(f))
          .toList(),
      isPrivate: json['is_private'],
      institution: json['institution'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      teams: List<String>.from(json['teams']),
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
  final Location location;

  Field({required this.id, required this.name, required this.location});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      id: json['_id'],
      name: json['name'],
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
      coordinates: List<double>.from(json['coordinates']),
    );
  }
}

class CreatedBy {
  final String id;
  final String name;

  CreatedBy({required this.id, required this.name});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(id: json['_id'], name: json['name']);
  }
}
