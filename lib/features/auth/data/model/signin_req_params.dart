class SigninReqParams {
  final String email, password;

  SigninReqParams({required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {"email": email, "password": password};
  }
}
