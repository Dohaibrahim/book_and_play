class SpecificTeamRes {
  final String message;
  final SpecificTeam team;

  SpecificTeamRes({required this.message, required this.team});

  factory SpecificTeamRes.fromJson(Map<String, dynamic> json) {
    return SpecificTeamRes(
      message: json['message'],
      team: SpecificTeam.fromJson(json['team']),
    );
  }
}

class SpecificTeam {
  final String id;
  final String name;
  final List<Member> members;
  final String createdBy;
  final SpecificTournament tournament;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  SpecificTeam({
    required this.id,
    required this.name,
    required this.members,
    required this.createdBy,
    required this.tournament,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SpecificTeam.fromJson(Map<String, dynamic> json) {
    return SpecificTeam(
      id: json['_id'],
      name: json['name'],
      members: (json['members'] as List)
          .map((member) => Member.fromJson(member))
          .toList(),
      createdBy: json['createdBy'],
      tournament: SpecificTournament.fromJson(json['tournament']),
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

class SpecificTournament {
  final String id;
  final String name;

  SpecificTournament({required this.id, required this.name});

  factory SpecificTournament.fromJson(Map<String, dynamic> json) {
    return SpecificTournament(id: json['_id'], name: json['name']);
  }
}
