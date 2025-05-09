import 'package:book_and_play/core/di/dependency_injection.dart';
import 'package:book_and_play/core/routing/app_router.dart';
import 'package:book_and_play/features/auth/presentation/sign_up_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      title: 'Book and Play',
      home: SignUpView(),
    );
  }
}
