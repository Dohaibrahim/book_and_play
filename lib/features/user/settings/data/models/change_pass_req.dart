class ChangePassReq {
  final String email;
  final String oldPassword;
  final String newPassword;

  ChangePassReq({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });

  factory ChangePassReq.fromJson(Map<String, dynamic> json) {
    return ChangePassReq(
      email: json['email'] ?? '',
      oldPassword: json['oldPassword'] ?? '',
      newPassword: json['newPassword'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}
