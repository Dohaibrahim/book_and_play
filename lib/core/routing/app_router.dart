import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/features/auth/presentation/sign_in_view.dart';
import 'package:book_and_play/features/auth/presentation/sign_up_view.dart';
import 'package:book_and_play/features/booking/presentation/location_selection.dart';
import 'package:book_and_play/features/home/presentation/home_view.dart';
import 'package:book_and_play/features/Bottom_nav/presentation/bottom_nav_view.dart';
import 'package:book_and_play/features/user_booking/presentation/user_booking_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.signInView:
        return MaterialPageRoute(builder: (_) => SignInView());
      case Routes.signUpView:
        return MaterialPageRoute(builder: (_) => SignUpView());
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.bottomNavView:
        return MaterialPageRoute(builder: (_) => BottomNavView());
      case Routes.userBookingView:
        return MaterialPageRoute(builder: (_) => UserBookingView());
      case Routes.bookingView:
        return MaterialPageRoute(
          builder: (builder) => const LocationSelectionView(),
        );
    }
    return null;
  }
}
