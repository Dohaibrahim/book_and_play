class SignupResponse {
  final String message;
  final User? user;

  SignupResponse({required this.message, required this.user});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      message: json['message'],
      user: json['user'] == null ? null : User.fromJson(json['user']),
    );
  }
}

class User {
  final String name;
  final String email;
  final Location location;
  final String role, country;
  final String id;

  final List<dynamic> match;

  User({
    required this.name,
    required this.email,
    required this.country,
    required this.location,
    required this.role,
    required this.id,

    required this.match,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      match: json['match'],
      country: json['country'],
      location: Location.fromJson(json['location']),
      role: json['role'],
      id: json['_id'],
    );
  }
}

class Location {
  final List<double> coordinates;
  final String type;

  Location({required this.coordinates, required this.type});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      coordinates: List<double>.from(json['coordinates']),
      type: json['type'],
    );
  }
}
