class SignupResponse {
  final String message;
  final User user;

  SignupResponse({required this.message, required this.user});

  factory SignupResponse.fromJson(Map<String, dynamic> json) {
    return SignupResponse(
      message: json['message'],
      user: User.fromJson(json['user']),
    );
  }
}

class User {
  final String name;
  final String email;
  final String password;
  final Location location;
  final String role;
  final String id;
  final String createdAt;
  final String updatedAt;
  final int v;

  User({
    required this.name,
    required this.email,
    required this.password,
    required this.location,
    required this.role,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'],
      email: json['email'],
      password: json['password'],
      location: Location.fromJson(json['location']),
      role: json['role'],
      id: json['_id'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
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
