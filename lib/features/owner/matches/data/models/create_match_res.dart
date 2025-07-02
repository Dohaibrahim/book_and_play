class CreateMatchRes {
  final String message;
  final Match match;

  CreateMatchRes({required this.message, required this.match});

  factory CreateMatchRes.fromJson(Map<String, dynamic> json) {
    return CreateMatchRes(
      message: json['message'],
      match: Match.fromJson(json['match']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'match': match.toJson()};
  }
}

class Match {
  final String fieldId;
  final String date;
  final MatchTime time;
  final MatchLocation location;
  final int maxPlayers;
  final List<String> currentPlayers;
  final String status;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  Match({
    required this.fieldId,
    required this.date,
    required this.time,
    required this.location,
    required this.maxPlayers,
    required this.currentPlayers,
    required this.status,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      fieldId: json['fieldId'],
      date: json['date'],
      time: MatchTime.fromJson(json['time']),
      location: MatchLocation.fromJson(json['location']),
      maxPlayers: json['max_players'],
      currentPlayers: List<String>.from(json['current_players']),
      status: json['status'],
      id: json['id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fieldId': fieldId,
      'date': date,
      'time': time.toJson(),
      'location': location.toJson(),
      'max_players': maxPlayers,
      'current_players': currentPlayers,
      'status': status,
      'id': id,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      '__v': v,
    };
  }
}

class MatchTime {
  final String start;
  final String end;

  MatchTime({required this.start, required this.end});

  factory MatchTime.fromJson(Map<String, dynamic> json) {
    return MatchTime(start: json['start'], end: json['end']);
  }

  Map<String, dynamic> toJson() {
    return {'start': start, 'end': end};
  }
}

class MatchLocation {
  final String type;
  final List<double> coordinates;

  MatchLocation({required this.type, required this.coordinates});

  factory MatchLocation.fromJson(Map<String, dynamic> json) {
    return MatchLocation(
      type: json['type'],
      coordinates: List<double>.from(
        json['coordinates'].map((e) => e.toDouble()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'coordinates': coordinates};
  }
}
