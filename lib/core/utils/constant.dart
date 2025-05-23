class ApiUrls {
  static const baseURL = 'https://book-and-play.vercel.app';
  static const String signup = '$baseURL/api/auth/signup';
  static const String signin = '$baseURL/api/auth/signin';
  static const String field = '$baseURL/api/field';
  static const String availableMatches = '$baseURL/api/match/available';
}

class SharedPrefKeys {
  static const String userToken = 'userToken';
  static const String username = 'username';
  static const String userEmail = 'userEmail';
  static const String userid = 'id';
  static const String userRole = 'userRole';
}
