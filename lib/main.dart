import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/routing/app_router.dart';
import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/core/utils/constant.dart';
import 'package:book_and_play/core/utils/shared_pref.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await EasyLocalization.ensureInitialized();
  String? userToken = await SharedPrefHelper.getString(
    SharedPrefKeys.userToken,
  );
  String? userRole = await SharedPrefHelper.getString(SharedPrefKeys.userRole);
  bool isLoggedInUser = userToken != null && userToken.isNotEmpty;
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('fr'),
        Locale('it'),
        Locale('pt'),
        Locale('zh'),
      ],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      startLocale: const Locale('en'),
      child: MyApp(isLoggedInUser: isLoggedInUser, userRole: userRole ?? ''),
    ),
  );
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
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: !isLoggedInUser
          ? Routes.onboardingView
          : (userRole == 'owner'
                ? Routes.ownerBottomNavView
                : Routes.userBottomNavView),
      title: 'Book and Play',
    );
  }
}
