class AddScoreRes {
  final String message;
  final AddScoreMatch match;

  AddScoreRes({required this.message, required this.match});

  factory AddScoreRes.fromJson(Map<String, dynamic> json) {
    return AddScoreRes(
      message: json['message'] ?? '',
      match: AddScoreMatch.fromJson(json['match']),
    );
  }
}

class AddScoreMatch {
  final MatchTime time;
  final MatchScore score;
  final String id;
  final String tournament;
  final String round;
  final String fieldId;
  final DateTime date;
  final String teamA;
  final String teamB;
  final String status;
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String winner;

  AddScoreMatch({
    required this.time,
    required this.score,
    required this.id,
    required this.tournament,
    required this.round,
    required this.fieldId,
    required this.date,
    required this.teamA,
    required this.teamB,
    required this.status,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
    required this.winner,
  });

  factory AddScoreMatch.fromJson(Map<String, dynamic> json) {
    return AddScoreMatch(
      time: MatchTime.fromJson(json['time']),
      score: MatchScore.fromJson(json['score']),
      id: json['_id'] ?? '',
      tournament: json['tournament'] ?? '',
      round: json['round'] ?? '',
      fieldId: json['fieldId'] ?? '',
      date: DateTime.parse(json['date']),
      teamA: json['teamA'] ?? '',
      teamB: json['teamB'] ?? '',
      status: json['status'] ?? '',
      v: json['__v'] ?? 0,
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      winner: json['winner'] ?? '',
    );
  }
}

class MatchTime {
  final String start;
  final String end;

  MatchTime({required this.start, required this.end});

  factory MatchTime.fromJson(Map<String, dynamic> json) {
    return MatchTime(start: json['start'] ?? '', end: json['end'] ?? '');
  }
}

class MatchScore {
  final int teamA;
  final int teamB;

  MatchScore({required this.teamA, required this.teamB});

  factory MatchScore.fromJson(Map<String, dynamic> json) {
    return MatchScore(teamA: json['teamA'] ?? 0, teamB: json['teamB'] ?? 0);
  }
}
