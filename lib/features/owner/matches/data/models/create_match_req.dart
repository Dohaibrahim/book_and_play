import 'package:book_and_play/features/owner/owner_fields/data/models/owner_fields.dart';

class CreateMatchReq {
  final String fieldId;
  final String date; // format: YYYY-MM-DD
  final MatchTime time;
  final Location location;
  final int maxPlayers;
  final List<String> currentPlayers;
  final String status;

  CreateMatchReq({
    required this.fieldId,
    required this.date,
    required this.time,
    required this.location,
    required this.maxPlayers,
    required this.currentPlayers,
    required this.status,
  });

  factory CreateMatchReq.fromJson(Map<String, dynamic> json) {
    return CreateMatchReq(
      fieldId: json['fieldId'],
      date: json['date'],
      time: MatchTime.fromJson(json['time']),
      location: Location.fromJson(json['location']),
      maxPlayers: json['max_players'],
      currentPlayers: List<String>.from(json['current_players']),
      status: json['status'],
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

/*
class MatchLocation {
  final String type;
  final List<double> coordinates; // [longitude, latitude]

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
}*/
