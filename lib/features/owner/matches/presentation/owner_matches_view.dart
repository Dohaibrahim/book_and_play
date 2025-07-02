import 'package:book_and_play/features/owner/owner_fields/presentation/widgets/owner_matches_view_body.dart';
import 'package:flutter/material.dart';

class OwnerMatchesView extends StatelessWidget {
  const OwnerMatchesView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: SafeArea(child: OwnerMatchesViewBody(fieldId: args)),
    );
  }
}
