class AddPlayerToTeamReq {
  final String teamId;
  final String memberId;

  AddPlayerToTeamReq({required this.teamId, required this.memberId});

  Map<String, dynamic> toJson() {
    return {'teamId': teamId, 'memberId': memberId};
  }
}
