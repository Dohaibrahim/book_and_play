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
  final String institution;
  final CreatedBy createdBy;
  final String status;
  final List<Team> teams;
  final String? winner;
  final String currentRound;

  Tournament({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.maxTeams,
    required this.isPrivate,
    required this.institution,
    required this.createdBy,
    required this.status,
    required this.teams,
    required this.winner,
    required this.currentRound,
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
      winner: json['winner'],
      currentRound: json['current_round'],
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
