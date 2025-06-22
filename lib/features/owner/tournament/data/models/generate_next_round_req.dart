class TimeReq {
  final String start;
  final String end;

  TimeReq({required this.start, required this.end});

  Map<String, dynamic> toJson() {
    return {'start': start, 'end': end};
  }
}

class NextRoundReq {
  final List<TimeReq> times;

  NextRoundReq({required this.times});

  Map<String, dynamic> toJson() {
    return {'times': times.map((t) => t.toJson()).toList()};
  }
}
