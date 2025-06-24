import 'package:latlong2/latlong.dart';

class ImportedGeodataPoint {

  ImportedGeodataPoint({
    required this.id,
    required this.lat,
    required this.lng,
    required this.categoryId,
  });

  factory ImportedGeodataPoint.fromJson(Map<String, dynamic> json) {
    return ImportedGeodataPoint(
      id: json['id'] as int,
      lat: json['lat'] as double,
      lng: json['lng'] as double,
      categoryId: json['categoryId'] as int,
    );
  }
  final int id;
  final double lat;
  final double lng;
  final int categoryId;

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lat': lat,
      'lng': lng,
      'categoryId': categoryId,
    };
  }

  LatLng get coordinates => LatLng(lat, lng);
}