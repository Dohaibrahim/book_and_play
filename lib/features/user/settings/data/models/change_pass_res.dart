class ChangePassRes {
  final String message;
  final String token;
  final User user;

  ChangePassRes({
    required this.message,
    required this.token,
    required this.user,
  });

  factory ChangePassRes.fromJson(Map<String, dynamic> json) {
    return ChangePassRes(
      message: json['message'] ?? '',
      token: json['token'] ?? '',
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'token': token, 'user': user.toJson()};
  }
}

class User {
  final String id;
  final String name;
  final String email;
  final String password;
  final String country;
  final int preferredDistance;
  final String role;
  final List<dynamic> match;
  final String createdAt;
  final String updatedAt;
  final Location location;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.country,
    required this.preferredDistance,
    required this.role,
    required this.match,
    required this.createdAt,
    required this.updatedAt,
    required this.location,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      country: json['country'] ?? '',
      preferredDistance: json['preferred_distance'] ?? 0,
      role: json['role'] ?? '',
      match: json['match'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      location: Location.fromJson(json['location']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'email': email,
      'password': password,
      'country': country,
      'preferred_distance': preferredDistance,
      'role': role,
      'match': match,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'location': location.toJson(),
    };
  }
}

class Location {
  final String type;
  final List<double> coordinates;

  Location({required this.type, required this.coordinates});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      type: json['type'] ?? '',
      coordinates: List<double>.from(
        json['coordinates'].map((x) => x.toDouble()),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'type': type, 'coordinates': coordinates};
  }
}
