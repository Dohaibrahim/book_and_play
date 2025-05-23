class AvailableMatchesModel {
  final String message;
  final List<MatchModel> matches;

  AvailableMatchesModel({required this.matches, required this.message});

  factory AvailableMatchesModel.fromJson(Map<String, dynamic> json) {
    var matches = json['matches'] as List;
    List<MatchModel> matechesList =
        matches.map((i) => MatchModel.fromJson(i)).toList();
    return AvailableMatchesModel(
      matches: matechesList,
      message: json['message'],
    );
  }
}

class MatchModel {
  final String id, fieldId, date, status;
  final int maxPlayers;
  final List<CurrentPlayerModel> currentPlayers;
  final TimeModel time;
  MatchModel({
    required this.currentPlayers,
    required this.status,
    required this.date,
    required this.fieldId,
    required this.id,
    required this.maxPlayers,
    required this.time,
  });

  factory MatchModel.fromJson(Map<String, dynamic> json) {
    var players = json['current_players'] as List;
    List<CurrentPlayerModel> currentPlyaers =
        players.map((i) => CurrentPlayerModel.fromJson(i)).toList();
    return MatchModel(
      currentPlayers: currentPlyaers,
      status: json['status'],
      id: json['id'],
      fieldId: json['fieldId'],
      date: json['date'],
      time: TimeModel.fromJson(json['time']),
      maxPlayers: json['max_players'],
    );
  }
}

class CurrentPlayerModel {
  final String name;
  final String id;
  CurrentPlayerModel({required this.id, required this.name});
  factory CurrentPlayerModel.fromJson(Map<String, dynamic> json) {
    return CurrentPlayerModel(id: json['_id'], name: json['name']);
  }
}

class TimeModel {
  final String start, end;

  TimeModel({required this.end, required this.start});

  factory TimeModel.fromJson(Map<String, dynamic> json) {
    return TimeModel(end: json['end'], start: json['start']);
  }
}
