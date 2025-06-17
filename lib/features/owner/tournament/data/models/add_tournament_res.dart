class AddTournamentResponse {
  final String message;
  final Tournament tournament;

  AddTournamentResponse({required this.message, required this.tournament});

  factory AddTournamentResponse.fromJson(Map<String, dynamic> json) {
    return AddTournamentResponse(
      message: json['message'],
      tournament: Tournament.fromJson(json['tournament']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'tournament': tournament.toJson()};
  }
}

class Tournament {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int maxTeams;
  final List<String> fieldIds;
  final bool isPrivate;
  final String? institution;
  final String createdBy;
  final List<dynamic> teams;
  final String type;
  final String status;
  final dynamic? winner;
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
    required this.institution,
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
      fieldIds: List<String>.from(json['field_ids']),
      isPrivate: json['is_private'],
      institution: json['institution'] ?? '',
      createdBy: json['createdBy'],
      teams: List<dynamic>.from(json['teams']),
      type: json['type'],
      status: json['status'],
      winner: json['winner'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'description': description,
      'start_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'max_teams': maxTeams,
      'field_ids': fieldIds,
      'is_private': isPrivate,
      'institution': institution,
      'createdBy': createdBy,
      'teams': teams,
      'type': type,
      'status': status,
      'winner': winner,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
