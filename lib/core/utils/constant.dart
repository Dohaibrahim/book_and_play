class ApiUrls {
  static const String baseURL = "http://192.168.1.2:3000";
  static const String signup = '$baseURL/api/auth/signup';
  static const String signin = '$baseURL/api/auth/signin';
}

class SharedPrefKeys {
  static const String userToken = 'userToken';
  static const String username = 'username';
  static const String userEmail = 'userEmail';
  static const String userid = 'id';
}
