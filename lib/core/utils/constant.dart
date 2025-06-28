class ApiUrls {
  static const baseURL = 'https://book-and-play.vercel.app';
  static const String signup = '$baseURL/api/auth/signup';
  static const String signin = '$baseURL/api/auth/signin';
  static const String field = '$baseURL/api/field';
  static const String availableMatches = '$baseURL/api/match/available';
  static const String match = '$baseURL/api/match';
  static const String tournament = '$baseURL/api/tournament';
  static const String searchPlaces = '$baseURL/api/field/search-place';
  static const String knockoutTournaments = '$baseURL/api/knockout/tournaments';
  static const String team = '$baseURL/api/team';
}

class SharedPrefKeys {
  static const String userToken = 'userToken';
  static const String username = 'username';
  static const String userEmail = 'userEmail';
  static const String userid = 'id';
  static const String userRole = 'userRole';
}
