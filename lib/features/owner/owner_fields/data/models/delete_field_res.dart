class DeletedFieldResponse {
  final String message;
  final OwnerFieldDelete field;

  DeletedFieldResponse({required this.message, required this.field});

  factory DeletedFieldResponse.fromJson(Map<String, dynamic> json) {
    return DeletedFieldResponse(
      message: json['message'],
      field: OwnerFieldDelete.fromJson(json['field']),
    );
  }
}

class OwnerFieldDelete {
  final String id;
  final String name;
  final String city;
  final String country;
  final int capacity;
  final bool isPaid;
  final int pricePerHour;
  final String locationInfo;
  final String owner;

  OwnerFieldDelete({
    required this.id,
    required this.name,
    required this.city,
    required this.country,
    required this.capacity,
    required this.isPaid,
    required this.pricePerHour,
    required this.locationInfo,
    required this.owner,
  });

  factory OwnerFieldDelete.fromJson(Map<String, dynamic> json) {
    return OwnerFieldDelete(
      id: json['_id'],
      name: json['name'],
      city: json['city'],
      country: json['country'],
      capacity: json['capacity'],
      isPaid: json['is_paid'],
      pricePerHour: json['price_per_hour'],
      locationInfo: json['location_info'],
      owner: json['owner'],
    );
  }
}
