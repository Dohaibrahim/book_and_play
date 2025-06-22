class NextRoundRes {
  final String message;
  final List<Match> matches;

  NextRoundRes({required this.message, required this.matches});

  factory NextRoundRes.fromJson(Map<String, dynamic> json) {
    return NextRoundRes(
      message: json['message'],
      matches: (json['matches'] as List).map((e) => Match.fromJson(e)).toList(),
    );
  }
}

class Match {
  final String tournament;
  final String round;
  final Field fieldId;
  final DateTime date;
  final Time time;
  final String teamA;
  final String teamB;
  final Score score;
  final String status;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;

  Match({
    required this.tournament,
    required this.round,
    required this.fieldId,
    required this.date,
    required this.time,
    required this.teamA,
    required this.teamB,
    required this.score,
    required this.status,
    required this.id,

    required this.createdAt,
    required this.updatedAt,
  });

  factory Match.fromJson(Map<String, dynamic> json) {
    return Match(
      tournament: json['tournament'],
      round: json['round'],
      fieldId: Field.fromJson(json['fieldId']),
      date: DateTime.parse(json['date']),
      time: Time.fromJson(json['time']),
      teamA: json['teamA'],
      teamB: json['teamB'],
      score: Score.fromJson(json['score']),
      status: json['status'],
      id: json['_id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
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
  final List<dynamic> amenities;
  final int v;
  final Location location;

  Field({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.capacity,
    required this.isPaid,
    required this.pricePerHour,
    required this.amenities,
    required this.v,
    required this.location,
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
      amenities: json['amenities'],
      v: json['__v'],
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

class Time {
  final String start;
  final String end;

  Time({required this.start, required this.end});

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(start: json['start'], end: json['end']);
  }
}

class Score {
  final dynamic teamA;
  final dynamic teamB;

  Score({this.teamA, this.teamB});

  factory Score.fromJson(Map<String, dynamic> json) {
    return Score(teamA: json['teamA'], teamB: json['teamB']);
  }
}
