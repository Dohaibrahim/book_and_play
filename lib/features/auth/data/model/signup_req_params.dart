class SignupReqParams {
  final String name;
  final String email;
  final String password;
  final String repassword, role;
  final Location location;

  SignupReqParams({
    required this.location,
    required this.email,
    required this.name,
    required this.password,
    required this.repassword,
    required this.role,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'password': password,
      'repassword': repassword,
      'location': location.toJson(),
    };
  }
}

class Location {
  final List<double> coordinates;

  Location({required this.coordinates});

  Map<String, dynamic> toJson() {
    return {'coordinates': coordinates};
  }
}
