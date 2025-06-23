class TeamsMatchesRes {
  final String tournamentId;
  final String status;
  final Rounds rounds;

  TeamsMatchesRes({
    required this.tournamentId,
    required this.status,
    required this.rounds,
  });

  factory TeamsMatchesRes.fromJson(Map<String, dynamic> json) {
    return TeamsMatchesRes(
      tournamentId: json['tournamentId'],
      status: json['status'],
      rounds: Rounds.fromJson(json['rounds']),
    );
  }
}

class Rounds {
  final List<MatchScheduled> roundOf16;
  final List<MatchScheduled> quarterfinal;
  final List<MatchScheduled> semifinal;
  final List<MatchScheduled> finalRound;

  Rounds({
    required this.roundOf16,
    required this.quarterfinal,
    required this.semifinal,
    required this.finalRound,
  });

  factory Rounds.fromJson(Map<String, dynamic> json) {
    return Rounds(
      roundOf16: (json['round_of_16'] as List)
          .map((e) => MatchScheduled.fromJson(e))
          .toList(),
      quarterfinal: (json['quarterfinal'] as List)
          .map((e) => MatchScheduled.fromJson(e))
          .toList(),
      semifinal: (json['semifinal'] as List)
          .map((e) => MatchScheduled.fromJson(e))
          .toList(),
      finalRound: (json['final'] as List)
          .map((e) => MatchScheduled.fromJson(e))
          .toList(),
    );
  }
}

class MatchScheduled {
  final String id;
  final String tournament;
  final String round;
  final String fieldId;
  final DateTime date;
  final Team teamA;
  final Team teamB;
  final String status;
  final Score score;
  final MatchTime time;
  final int v;
  final DateTime createdAt;
  final DateTime updatedAt;

  MatchScheduled({
    required this.id,
    required this.tournament,
    required this.round,
    required this.fieldId,
    required this.date,
    required this.teamA,
    required this.teamB,
    required this.status,
    required this.score,
    required this.time,
    required this.v,
    required this.createdAt,
    required this.updatedAt,
  });

  factory MatchScheduled.fromJson(Map<String, dynamic> json) {
    return MatchScheduled(
      id: json['_id'],
      tournament: json['tournament'],
      round: json['round'],
      fieldId: json['fieldId'],
      date: DateTime.parse(json['date']),
      teamA: Team.fromJson(json['teamA']),
      teamB: Team.fromJson(json['teamB']),
      status: json['status'],
      score: Score.fromJson(json['score']),
      time: MatchTime.fromJson(json['time']),
      v: json['__v'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Team {
  final String id;
  final String name;

  Team({required this.id, required this.name});

  factory Team.fromJson(Map<String, dynamic> json) {
    return Team(id: json['_id'], name: json['name']);
  }
}

class Score {
  final int? teamA;
  final int? teamB;

  Score({this.teamA, this.teamB});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(teamA: json['teamA'], teamB: json['teamB']);
  }
}

class MatchTime {
  final String start;
  final String end;

  MatchTime({required this.start, required this.end});

  factory MatchTime.fromJson(Map<String, dynamic> json) {
    return MatchTime(start: json['start'], end: json['end']);
  }
}
