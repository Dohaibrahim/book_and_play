class SignupReqParams {
  final String name;
  final String email;
  final String password;
  final String repassword, role, country;
  final Location location;
  final int? preferred_distance;
  SignupReqParams({
    required this.preferred_distance,
    required this.location,
    required this.email,
    required this.name,
    required this.password,
    required this.repassword,
    required this.role,
    required this.country,
  });

  Map<String, dynamic> toJson(String userRole) {
    return {
      'name': name,
      'country': country,
      'email': email,
      'password': password,
      'repassword': repassword,
      'location': location.toJson(),
      'preferred_distance': preferred_distance,
      'role': userRole,
    };
  }
}

class Location {
  final List<double> coordinates;
  final String type;

  Location({required this.type, required this.coordinates});

  Map<String, dynamic> toJson() {
    return {'coordinates': coordinates, 'type': type};
  }
}
