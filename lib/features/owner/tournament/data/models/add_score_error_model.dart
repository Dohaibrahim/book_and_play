class AddScoreErrorModel {
  final String error;
  final String message;
  final int code;

  AddScoreErrorModel({
    required this.error,
    required this.message,
    required this.code,
  });

  factory AddScoreErrorModel.fromJson(Map<String, dynamic> json) {
    return AddScoreErrorModel(
      error: json['error'] ?? '',
      message: json['message'] ?? '',
      code: json['code'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {'error': error, 'message': message, 'code': code};
  }
}
