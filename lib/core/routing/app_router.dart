import 'package:book_and_play/core/routing/routes.dart';
import 'package:book_and_play/features/auth/presentation/sign_in_view.dart';
import 'package:book_and_play/features/auth/presentation/sign_up_view.dart';
import 'package:book_and_play/features/user/booking/presentation/book_now_view.dart';
import 'package:book_and_play/features/user/booking/presentation/choose_football_field_view.dart';
import 'package:book_and_play/features/user/booking/presentation/football_field_view.dart';
import 'package:book_and_play/features/user/booking/presentation/location_selection.dart';
import 'package:book_and_play/features/user/home/presentation/home_view.dart';
import 'package:book_and_play/features/user/Bottom_nav/presentation/bottom_nav_view.dart';
import 'package:book_and_play/features/onboarding/presentation/onboarding_view.dart';
import 'package:book_and_play/features/owner/owner_home/presentation/owner_home_view.dart';
import 'package:book_and_play/features/user/user_booking/presentation/user_booked_field_view.dart';
import 'package:book_and_play/features/user/user_booking/presentation/user_booking_view.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final arguments = settings.arguments;

    switch (settings.name) {
      case Routes.signInView:
        return MaterialPageRoute(builder: (_) => SignInView());
      case Routes.signUpView:
        return MaterialPageRoute(
          builder: (_) => SignUpView(),
          settings: settings,
        );
      case Routes.onboardingView:
        return MaterialPageRoute(builder: (_) => const OnboardingView());
      case Routes.homeView:
        return MaterialPageRoute(builder: (_) => HomeView());
      case Routes.ownerBottomNavView:
        return MaterialPageRoute(
          builder: (_) => BottomNavView(home: OwnerHomeView()),
        );
      case Routes.userBottomNavView:
        return MaterialPageRoute(
          builder: (_) => BottomNavView(home: HomeView()),
        );
      case Routes.userBookingView:
        return MaterialPageRoute(builder: (_) => UserBookingView());
      case Routes.bookingView:
        return MaterialPageRoute(
          builder: (builder) => const LocationSelectionView(),
        );
      case Routes.chooseFootballFieldView:
        return MaterialPageRoute(
          builder: (_) => const ChooseFootballFieldView(),
        );
      case Routes.footballFieldView:
        final args = settings.arguments as String;
        return MaterialPageRoute(
          settings: settings,
          builder: (_) => FootballFieldView(fieldId: args),
        );
      case Routes.userBookedFieldView:
        return MaterialPageRoute(builder: (_) => const UserBookedFieldView());
      case Routes.bookNowView:
        return MaterialPageRoute(
          builder: (_) => const BookNowView(),
          settings: settings,
        );
    }
    return null;
  }
}
