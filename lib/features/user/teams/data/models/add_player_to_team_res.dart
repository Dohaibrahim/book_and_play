class AddPlayerToTeamRes {
  final String message;
  final Team team;

  AddPlayerToTeamRes({required this.message, required this.team});

  factory AddPlayerToTeamRes.fromJson(Map<String, dynamic> json) {
    return AddPlayerToTeamRes(
      message: json['message'],
      team: Team.fromJson(json['team']),
    );
  }
}

class Team {
  final String id;
  final String name;
  final List<Member> members;
  final String createdBy;
  final Tournament tournament;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Team({
    required this.id,
    required this.name,
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
      members: (json['members'] as List)
          .map((e) => Member.fromJson(e))
          .toList(),
      createdBy: json['createdBy'],
      tournament: Tournament.fromJson(json['tournament']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}

class Member {
  final String id;
  final String name;
  final String email;

  Member({required this.id, required this.name, required this.email});

  factory Member.fromJson(Map<String, dynamic> json) {
    return Member(id: json['_id'], name: json['name'], email: json['email']);
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
  final String institution;
  final String createdBy;
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
    required this.institution,
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
      fieldIds: List<String>.from(json['field_ids']),
      isPrivate: json['is_private'],
      institution: json['institution'],
      createdBy: json['createdBy'],
      teams: List<String>.from(json['teams']),
      type: json['type'],
      status: json['status'],
      winner: json['winner'], // nullable
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }
}
