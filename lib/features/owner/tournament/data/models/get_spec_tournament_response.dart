class SpecificTournamentResponse {
  final String message;
  final Tournament tournament;

  SpecificTournamentResponse({required this.message, required this.tournament});

  factory SpecificTournamentResponse.fromJson(Map<String, dynamic> json) {
    return SpecificTournamentResponse(
      message: json['message'],
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
  final List<Field> fieldIds;
  final bool isPrivate;
  final String? institution;
  final Creator createdBy;
  final List<Team> teams;
  final String type;
  final String status;
  final String? winner;

  Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.maxTeams,
    required this.fieldIds,
    required this.isPrivate,
    required this.institution,
    required this.createdBy,
    required this.teams,
    required this.type,
    required this.status,
    required this.winner,
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
          .map((e) => Field.fromJson(e))
          .toList(),
      isPrivate: json['is_private'],
      institution: json['institution'],
      createdBy: Creator.fromJson(json['createdBy']),
      teams: (json['teams'] as List).map((e) => Team.fromJson(e)).toList(),
      type: json['type'],
      status: json['status'],
      winner: json['winner'] ?? '',
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
  final String? owner;
  final List<dynamic> amenities;

  Field({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.capacity,
    required this.isPaid,
    required this.pricePerHour,
    required this.owner,
    required this.amenities,
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
      owner: json['owner'] ?? '',
      amenities: json['amenities'],
    );
  }
}

class Creator {
  final String id;
  final String name;
  final String email;

  Creator({required this.id, required this.name, required this.email});

  factory Creator.fromJson(Map<String, dynamic> json) {
    return Creator(id: json['_id'], name: json['name'], email: json['email']);
  }
}

class Team {
  final String id;
  final String name;
  final List<String> members;
  final String createdBy;
  final String tournament;
  final DateTime createdAt;
  final DateTime updatedAt;

  Team({
    required this.id,
    required this.name,
    required this.members,
    required this.createdBy,
    required this.tournament,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(
      id: json['_id'],
      name: json['name'],
      members: List<String>.from(json['members']),
      createdBy: json['createdBy'],
      tournament: json['tournament'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}
