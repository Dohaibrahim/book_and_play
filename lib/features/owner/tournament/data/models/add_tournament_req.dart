class AddTournamentReq {
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final int maxTeams;
  final List<String> fieldIds;
  final bool isPrivate;
  final String institution;
  final String type;

  AddTournamentReq({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.maxTeams,
    required this.fieldIds,
    required this.isPrivate,
    required this.institution,
    required this.type,
  });

  factory AddTournamentReq.fromJson(Map<String, dynamic> json) {
    return AddTournamentReq(
      name: json['name'],
      description: json['description'],
      startDate: DateTime.parse(json['start_date'].replaceAll('/', '-')),
      endDate: DateTime.parse(json['end_date'].replaceAll('/', '-')),
      maxTeams: json['max_teams'],
      fieldIds: List<String>.from(json['field_ids']),
      isPrivate: json['is_private'],
      institution: json['institution'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'start_date': "${startDate.year}/${startDate.month}/${startDate.day}",
      'end_date': "${endDate.year}/${endDate.month}/${endDate.day}",
      'max_teams': maxTeams,
      'field_ids': fieldIds,
      'is_private': isPrivate,
      'institution': institution,
      'type': type,
    };
  }
}
