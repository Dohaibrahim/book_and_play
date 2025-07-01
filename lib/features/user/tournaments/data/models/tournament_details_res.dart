class TournamentDetailsRes {
  final Tournament tournament;

  TournamentDetailsRes({required this.tournament});

  factory TournamentDetailsRes.fromJson(Map<String, dynamic> json) {
    return TournamentDetailsRes(
      tournament: Tournament.fromJson(json['tournament']),
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
  final bool isPrivate;
  final String? institution;
  final CreatedBy createdBy;
  final String status;
  final List<Team> teams;
  final Winner? winner;
  final String currentRound;
  final List<Field> fields;

  Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.maxTeams,
    required this.isPrivate,
    this.institution,
    required this.createdBy,
    required this.status,
    required this.teams,
    required this.winner,
    required this.currentRound,
    required this.fields,
  });

  factory Tournament.fromJson(Map<String, dynamic> json) {
    return Tournament(
      id: json['_id'],
      name: json['name'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
      maxTeams: json['max_teams'],
      isPrivate: json['is_private'],
      institution: json['institution'],
      createdBy: CreatedBy.fromJson(json['createdBy']),
      status: json['status'],
      teams: (json['teams'] as List)
          .map((teamJson) => Team.fromJson(teamJson))
          .toList(),
      winner: json['winner'] != null ? Winner.fromJson(json['winner']) : null,
      currentRound: json['current_round'],
      fields: (json['fields'] as List)
          .map((fieldJson) => Field.fromJson(fieldJson))
          .toList(),
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

class Team {
  final String id;
  final String name;
  final List<String> members;

  Team({required this.id, required this.name, required this.members});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'],
      name: json['name'],
      members: List<String>.from(json['members']),
    );
  }
}

class Winner {
  final String id;
  final String name;

  Winner({required this.id, required this.name});

  factory Winner.fromJson(Map<String, dynamic> json) {
    return Winner(id: json['_id'], name: json['name']);
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
