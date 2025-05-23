class JoinMatchModel {
  final String message;
  final MatchBooked match;

  JoinMatchModel({required this.message, required this.match});

  factory JoinMatchModel.fromJson(Map<String, dynamic> json) {
    return JoinMatchModel(
      message: json['message'],
      match: MatchBooked.fromJson(json['match']),
    );
  }
}

class MatchBooked {
  final Time time;
  //final Location location;
  final String id;
  final String fieldId;
  final DateTime date;
  final int maxPlayers;
  final List<String> currentPlayers;
  final String status;

  MatchBooked({
    required this.time,

    required this.id,
    required this.fieldId,
    required this.date,
    required this.maxPlayers,
    required this.currentPlayers,
    required this.status,
  });

  factory MatchBooked.fromJson(Map<String, dynamic> json) {
    return MatchBooked(
      time: Time.fromJson(json['time']),
      //location: Location.fromJson(json['location']),
      id: json['_id'],
      fieldId: json['fieldId'],
      date: DateTime.parse(json['date']),
      maxPlayers: json['max_players'],
      currentPlayers: List<String>.from(json['current_players']),
      status: json['status'],
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
