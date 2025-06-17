import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/routing/app_router.dart';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  String? userToken = await SharedPrefHelper.getString(
    SharedPrefKeys.userToken,
  );
  String? userRole = await SharedPrefHelper.getString(SharedPrefKeys.userRole);
  bool isLoggedInUser = userToken != null && userToken.isNotEmpty;
  runApp(MyApp(isLoggedInUser: isLoggedInUser, userRole: userRole ?? ''));
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.isLoggedInUser,
    required this.userRole,
  });
  final bool isLoggedInUser;
  final String userRole;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: !isLoggedInUser
          ? Routes.onboardingView
          : (userRole == 'owner'
                ? Routes.ownerBottomNavView
                : Routes.userBottomNavView),
      // later will be sign in
      title: 'Book and Play',
    );
  }
}

//10 -> max players
// 3/10
// 7 players left 
// open , full , complete (status) based on status , if completed user can't fetch (book) the match 