class StartTournamentsResPonse {
  final String message;
  final String status;

  StartTournamentsResPonse({required this.message, required this.status});

  factory StartTournamentsResPonse.fromJson(Map<String, dynamic> json) {
    return StartTournamentsResPonse(
      message: json['message'],
      status: json['status'],
    );
  }
}
