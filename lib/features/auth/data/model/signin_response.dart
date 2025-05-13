class SigninResponse {
  final String message, token;
  final User? user;

  SigninResponse({
    required this.message,
    required this.token,
    required this.user,
  });

  factory SigninResponse.fromJson(Map<String, dynamic> json) {
    return SigninResponse(
      message: json['message'],
      token: json['token'],
      user: json['user'] == null ? null : User.fromJson(json['user']),
    );
  }
}

class User {
  final String id, name, email, country;
  final List<dynamic> match;

  User({
    required this.id,
    required this.country,
    required this.email,
    required this.match,
    required this.name,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      country: json['country'],
      email: json['email'],
      match: json['match'],
      name: json['name'],
    );
  }
}
