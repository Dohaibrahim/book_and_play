class TeamCreateResponse {
  final String message;
  final PlayerTeam team;

  TeamCreateResponse({required this.message, required this.team});

  factory TeamCreateResponse.fromJson(Map<String, dynamic> json) {
    return TeamCreateResponse(
      message: json['message'],
      team: PlayerTeam.fromJson(json['team']),
    );
  }
}

class PlayerTeam {
  final String id;
  final String name;
  final String tournament;
  final String createdBy;
  final List<String> members;
  final DateTime createdAt;

  PlayerTeam({
    required this.id,
    required this.name,
    required this.tournament,
    required this.createdBy,
    required this.members,
    required this.createdAt,
  });

  factory PlayerTeam.fromJson(Map<String, dynamic> json) {
    return PlayerTeam(
      id: json['_id'],
      name: json['name'],
      tournament: json['tournament'],
      createdBy: json['createdBy'],
      members: List<String>.from(json['members']),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
