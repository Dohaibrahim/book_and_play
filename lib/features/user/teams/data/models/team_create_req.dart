import 'dart:io';
import 'package:dio/dio.dart';

class CreateTeamRequest {
  final String name;
  final String tournamentId;
  final File logo;

  CreateTeamRequest({
    required this.name,
    required this.tournamentId,
    required this.logo,
  });

  Future<FormData> toFormData() async {
    return FormData.fromMap({
      'name': name,
      'tournamentId': tournamentId,
      'logo': await MultipartFile.fromFile(
        logo.path,
        filename: logo.path.split('/').last,
      ),
    });
  }
}
