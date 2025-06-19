class PlacesResponse {
  final String message;
  final List<Place> places;

  PlacesResponse({required this.message, required this.places});

  factory PlacesResponse.fromJson(Map<String, dynamic> json) {
    return PlacesResponse(
      message: json['message'],
      places: (json['places'] as List)
          .map((place) => Place.fromJson(place))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'places': places.map((place) => place.toJson()).toList(),
    };
  }
}

class Place {
  final String name;
  final String address;
  final Location location;
  final String placeId;

  Place({
    required this.name,
    required this.address,
    required this.location,
    required this.placeId,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      address: json['address'],
      location: Location.fromJson(json['location']),
      placeId: json['place_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'location': location.toJson(),
      'place_id': placeId,
    };
  }
}

class Location {
  final double lat;
  final double lng;

  Location({required this.lat, required this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: (json['lat'] as num).toDouble(),
      lng: (json['lng'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'lat': lat, 'lng': lng};
  }
}
