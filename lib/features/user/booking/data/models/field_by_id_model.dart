import 'package:book_and_play/features/user/booking/data/models/all_fields_res.dart';

class FieldByIdModel {
  final String message;
  final Field field;
  FieldByIdModel({required this.field, required this.message});

  factory FieldByIdModel.fromJson(Map<String, dynamic> json) {
    return FieldByIdModel(
      field: Field.fromJson(json['field']),
      message: json['message'],
    );
  }
}
