class AddScoreReq {
  final int scoreA;
  final int scoreB;
  final String winnerId;

  AddScoreReq({
    required this.scoreA,
    required this.scoreB,
    required this.winnerId,
  });

  factory AddScoreReq.fromJson(Map<String, dynamic> json) {
    return AddScoreReq(
      scoreA: json['scoreA'] ?? 0,
      scoreB: json['scoreB'] ?? 0,
      winnerId: json['winnerId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'scoreA': scoreA, 'scoreB': scoreB, 'winnerId': winnerId};
  }
}
